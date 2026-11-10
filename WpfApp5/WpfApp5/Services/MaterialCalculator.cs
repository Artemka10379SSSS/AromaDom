using System;
using System.Collections.Generic;

namespace WpfApp5.Services
{
    public static class MaterialCalculator
    {
        // требуемое количество = сумма количества материала по всем продуктам где он есть, округляем до 2 знаков
        public static decimal CalculateRequiredQuantity(IEnumerable<decimal> quantitiesPerProduct)
        {
            if (quantitiesPerProduct == null)
            {
                return 0m;
            }

            decimal totalQuantity = 0m;

            foreach (decimal quantity in quantitiesPerProduct)
            {
                // отрицательные значения это ошибка в данных, их не считаем
                if (quantity > 0m)
                {
                    totalQuantity += quantity;
                }
            }

            return Math.Round(totalQuantity, 2, MidpointRounding.AwayFromZero);
        }
    }
}
