using System;
using Microsoft.Data.SqlClient;

namespace WpfApp5.Services
{
    public static class ProductCalculator
    {
        private const string ConnectionString =
            "Server=DESKTOP-38DMH77\\SQLEXPRESS;Database=AromaDom;Trusted_Connection=True;TrustServerCertificate=True";

        // возвращает сколько целых единиц продукции получится из materialAmount сырья
        // или -1 если тип не найден или данные неправильные
        public static int CalculateProductCount(int productTypeId, int materialTypeId, int materialAmount,
            double firstParameter, double secondParameter)
        {
            if (materialAmount < 0)
            {
                return -1;
            }

            if (double.IsNaN(firstParameter) || double.IsInfinity(firstParameter) || firstParameter <= 0)
            {
                return -1;
            }

            if (double.IsNaN(secondParameter) || double.IsInfinity(secondParameter) || secondParameter <= 0)
            {
                return -1;
            }

            double coefficient;
            double lossPercent;

            try
            {
                coefficient = GetProductTypeCoefficient(productTypeId);
                lossPercent = GetMaterialLossPercent(materialTypeId);
            }
            catch (Exception)
            {
                return -1;
            }

            if (coefficient <= 0 || lossPercent < 0 || lossPercent >= 100)
            {
                return -1;
            }

            double materialPerProduct = firstParameter * secondParameter * coefficient;

            // в базе процент хранится как число (0,12 = 0,12%), поэтому делим на 100
            double usableMaterial = materialAmount * (1 - lossPercent / 100);
            double count = Math.Floor(usableMaterial / materialPerProduct);

            if (double.IsNaN(count) || double.IsInfinity(count) || count > int.MaxValue)
            {
                return -1;
            }

            return (int)count;
        }

        private static double GetProductTypeCoefficient(int productTypeId)
        {
            return GetValue("SELECT Coefficient FROM ProductTypes WHERE Id = @id", productTypeId);
        }

        private static double GetMaterialLossPercent(int materialTypeId)
        {
            return GetValue("SELECT LossPercent FROM MaterialTypes WHERE Id = @id", materialTypeId);
        }

        // если записи нет, возвращает -1 (дальше это отсекается проверкой)
        private static double GetValue(string query, int id)
        {
            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                connection.Open();
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@id", id);
                object result = command.ExecuteScalar();

                if (result == null || result == DBNull.Value)
                {
                    return -1;
                }

                return Convert.ToDouble(result);
            }
        }
    }
}
