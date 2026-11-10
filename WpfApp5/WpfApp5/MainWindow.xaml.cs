using System;
using System.IO;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using Microsoft.Data.SqlClient;
using WpfApp5.Data;
using WpfApp5.Models;

namespace WpfApp5
{
    public partial class MainWindow : Window
    {
        private readonly MaterialRepository materialRepository = new MaterialRepository();

        public MainWindow()
        {
            InitializeComponent();
            LoadBranding();
            LoadMaterials();
        }

        private void AddButton_Click(object sender, RoutedEventArgs e)
        {
            OpenEditWindow(null);
        }

        private void MaterialsListBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            Material selected = MaterialsListBox.SelectedItem as Material;

            if (selected == null)
            {
                return;
            }

            // сбрасываем выделение, чтобы по той же карточке можно было нажать ещё раз
            MaterialsListBox.SelectedItem = null;
            OpenEditWindow(selected);
        }

        private void ProductsButton_Click(object sender, RoutedEventArgs e)
        {
            Button button = (Button)sender;
            Material material = button.DataContext as Material;

            if (material == null)
            {
                return;
            }

            ProductsWindow productsWindow = new ProductsWindow(material);
            productsWindow.Owner = this;
            productsWindow.Icon = Icon;
            productsWindow.ShowDialog();
        }

        private void OpenEditWindow(Material material)
        {
            MaterialEditWindow editWindow = new MaterialEditWindow(material);
            editWindow.Owner = this;
            editWindow.Icon = Icon;
            editWindow.ShowDialog();
            LoadMaterials();
        }

        private void LoadMaterials()
        {
            try
            {
                MaterialsListBox.ItemsSource = materialRepository.GetMaterials();
            }
            catch (SqlException exception)
            {
                MessageBox.Show(
                    "Не удалось подключиться к базе данных AromaDom.\n\n" +
                    "Проверьте, что SQL Server запущен и база данных создана " +
                    "(скрипт AromaDom.sql), затем перезапустите приложение.\n\n" +
                    "Подробности: " + exception.Message,
                    "Ошибка подключения к базе данных",
                    MessageBoxButton.OK,
                    MessageBoxImage.Error);
            }
            catch (Exception exception)
            {
                MessageBox.Show(
                    "Не удалось загрузить список материалов.\n\n" +
                    "Подробности: " + exception.Message,
                    "Ошибка",
                    MessageBoxButton.OK,
                    MessageBoxImage.Error);
            }
        }

        // логотип и иконка берутся из папки Resources рядом с exe, если их нет то окно откроется без них
        private void LoadBranding()
        {
            string resourcesFolder = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "Resources");
            string logoPath = Path.Combine(resourcesFolder, "logo.png");
            string iconPath = Path.Combine(resourcesFolder, "icon.ico");

            ImageSource logo = LoadImage(logoPath);
            ImageSource icon = LoadImage(iconPath);

            if (logo != null)
            {
                LogoImage.Source = logo;
            }

            if (icon != null)
            {
                Icon = icon;
            }
        }

        private static ImageSource LoadImage(string path)
        {
            if (!File.Exists(path))
            {
                return null;
            }

            try
            {
                return BitmapFrame.Create(new Uri(path, UriKind.Absolute), BitmapCreateOptions.None, BitmapCacheOption.OnLoad);
            }
            catch (Exception)
            {
                return null;
            }
        }
    }
}
