using System.Globalization;

namespace WpfApp5.Models
{
    public class Material
    {
        private static readonly CultureInfo RussianCulture = new CultureInfo("ru-RU");

        public int Id { get; set; }

        public int MaterialTypeId { get; set; }

        public string MaterialTypeName { get; set; }

        public string Name { get; set; }

        public decimal UnitPrice { get; set; }

        public string Unit { get; set; }

        public decimal PackageQuantity { get; set; }

        public decimal StockQuantity { get; set; }

        public decimal MinQuantity { get; set; }

        public decimal RequiredQuantity { get; set; }

        public string HeaderText => $"{MaterialTypeName} | {Name}";

        public string MinQuantityText => $"Минимальное количество: {FormatQuantity(MinQuantity)} {Unit}";

        public string StockQuantityText => $"Количество на складе: {FormatQuantity(StockQuantity)} {Unit}";

        public string PriceText => $"Цена: {UnitPrice.ToString("0.00", RussianCulture)} р / Единица измерения: {Unit}";

        public string RequiredQuantityText => $"Требуемое количество: {RequiredQuantity.ToString("0.00", RussianCulture)} {Unit}";

        private static string FormatQuantity(decimal quantity)
        {
            return quantity.ToString("0.###", RussianCulture);
        }
    }
}
