using System;
using System.Collections.Generic;
using System.Windows;
using WpfApp5.Data;
using WpfApp5.Models;

namespace WpfApp5
{
    public partial class ProductsWindow : Window
    {
        private readonly MaterialRepository repository = new MaterialRepository();
        private readonly Material material;

        public ProductsWindow(Material material)
        {
            InitializeComponent();
            this.material = material;
            MaterialTextBlock.Text = "Материал: " + material.Name;
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            List<MaterialProduct> products;

            try
            {
                products = repository.GetProductsByMaterial(material.Id);
            }
            catch (Exception ex)
            {
                MessageBox.Show("Не удалось загрузить список продукции из базы данных.\n\nПроверьте подключение к SQL Server и откройте окно ещё раз.\n\n" + ex.Message,
                    "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                Close();
                return;
            }

            foreach (MaterialProduct product in products)
            {
                product.Unit = material.Unit;
            }

            ProductsListBox.ItemsSource = products;

            if (products.Count == 0)
            {
                EmptyTextBlock.Visibility = Visibility.Visible;
            }
        }

        private void BackButton_Click(object sender, RoutedEventArgs e)
        {
            Close();
        }
    }
}
