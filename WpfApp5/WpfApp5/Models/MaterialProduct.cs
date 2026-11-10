namespace WpfApp5.Models
{
    public class MaterialProduct
    {
        public string Article { get; set; }

        public string ProductName { get; set; }

        public decimal Quantity { get; set; }

        public string Unit { get; set; }

        public string HeaderText => Article + " | " + ProductName;

        public string QuantityText => "Количество материала на единицу продукции: " +
            Quantity.ToString("0.####", new System.Globalization.CultureInfo("ru-RU")) + " " + Unit;
    }
}
