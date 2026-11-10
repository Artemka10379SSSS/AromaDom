using System;
using System.Globalization;
using System.Text;
using System.Windows;
using Microsoft.Data.SqlClient;
using WpfApp5.Data;
using WpfApp5.Models;

namespace WpfApp5
{
    public partial class MaterialEditWindow : Window
    {
        private readonly MaterialRepository repository = new MaterialRepository();
        private readonly CultureInfo culture = new CultureInfo("ru-RU");
        private readonly Material material;

        // material = null значит добавление нового
        public MaterialEditWindow(Material material)
        {
            InitializeComponent();
            this.material = material;

            if (material == null)
            {
                Title = "Арома Дом — Добавление материала";
                HeaderTextBlock.Text = "Добавление материала";
            }
            else
            {
                Title = "Арома Дом — Редактирование материала";
                HeaderTextBlock.Text = "Редактирование материала";
            }
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            try
            {
                TypeComboBox.ItemsSource = repository.GetMaterialTypes();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Не удалось загрузить типы материалов из базы данных.\n\nПроверьте подключение к SQL Server и попробуйте открыть форму ещё раз.\n\n" + ex.Message,
                    "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                Close();
                return;
            }

            if (material != null)
            {
                TypeComboBox.SelectedValue = material.MaterialTypeId;
                NameTextBox.Text = material.Name;
                PriceTextBox.Text = material.UnitPrice.ToString("0.00", culture);
                UnitTextBox.Text = material.Unit;
                PackageTextBox.Text = material.PackageQuantity.ToString("0.###", culture);
                StockTextBox.Text = material.StockQuantity.ToString("0.###", culture);
                MinTextBox.Text = material.MinQuantity.ToString("0.###", culture);
            }
        }

        // принимаем и точку и запятую
        private bool TryParseNumber(string text, out decimal value)
        {
            string prepared = text.Trim().Replace('.', ',');
            return decimal.TryParse(prepared, NumberStyles.Number, culture, out value);
        }

        private void SaveButton_Click(object sender, RoutedEventArgs e)
        {
            StringBuilder errors = new StringBuilder();
            decimal price;
            decimal package;
            decimal stock;
            decimal min;

            if (TypeComboBox.SelectedValue == null)
            {
                errors.AppendLine("- выберите тип материала из списка");
            }

            if (string.IsNullOrWhiteSpace(NameTextBox.Text))
            {
                errors.AppendLine("- введите наименование материала");
            }

            if (!TryParseNumber(PriceTextBox.Text, out price))
            {
                errors.AppendLine("- цена должна быть числом, например 450,50");
            }
            else if (price < 0)
            {
                errors.AppendLine("- цена не может быть отрицательной");
            }
            else if (decimal.Round(price, 2) != price)
            {
                errors.AppendLine("- у цены может быть не больше двух знаков после запятой");
            }

            if (string.IsNullOrWhiteSpace(UnitTextBox.Text))
            {
                errors.AppendLine("- введите единицу измерения (кг, л, шт и т.д.)");
            }

            if (!TryParseNumber(PackageTextBox.Text, out package) || package <= 0)
            {
                errors.AppendLine("- количество в упаковке должно быть числом больше 0");
            }

            if (!TryParseNumber(StockTextBox.Text, out stock) || stock < 0)
            {
                errors.AppendLine("- количество на складе должно быть числом не меньше 0");
            }

            if (!TryParseNumber(MinTextBox.Text, out min))
            {
                errors.AppendLine("- минимальное количество должно быть числом");
            }
            else if (min < 0)
            {
                errors.AppendLine("- минимальное количество не может быть отрицательным");
            }

            if (errors.Length > 0)
            {
                MessageBox.Show("Материал не сохранён. Исправьте ошибки:\n\n" + errors.ToString(),
                    "Ошибка ввода", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }

            Material saved = new Material();
            saved.Id = material == null ? 0 : material.Id;
            saved.MaterialTypeId = (int)TypeComboBox.SelectedValue;
            saved.Name = NameTextBox.Text.Trim();
            saved.UnitPrice = price;
            saved.Unit = UnitTextBox.Text.Trim();
            saved.PackageQuantity = package;
            saved.StockQuantity = stock;
            saved.MinQuantity = min;

            try
            {
                repository.SaveMaterial(saved);
            }
            catch (SqlException ex) when (ex.Number == 2627 || ex.Number == 2601)
            {
                // 2627 и 2601 - нарушение уникальности (наименование уже есть в базе)
                MessageBox.Show("Материал с наименованием \"" + saved.Name + "\" уже есть в базе.\n\nВведите другое наименование.",
                    "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }
            catch (Exception ex)
            {
                MessageBox.Show("Не удалось сохранить материал в базу данных.\n\nПроверьте подключение к SQL Server и попробуйте ещё раз.\n\n" + ex.Message,
                    "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            MessageBox.Show("Материал успешно сохранён.", "Информация", MessageBoxButton.OK, MessageBoxImage.Information);
            Close();
        }

        private void BackButton_Click(object sender, RoutedEventArgs e)
        {
            MessageBoxResult result = MessageBox.Show("Вернуться к списку материалов?\nНесохранённые изменения будут потеряны.",
                "Предупреждение", MessageBoxButton.YesNo, MessageBoxImage.Warning);

            if (result == MessageBoxResult.Yes)
            {
                Close();
            }
        }
    }
}
