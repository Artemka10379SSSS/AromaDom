using System.Collections.Generic;
using Microsoft.Data.SqlClient;
using WpfApp5.Models;
using WpfApp5.Services;

namespace WpfApp5.Data
{
    public class MaterialRepository
    {
        private const string ConnectionString =
            "Server=DESKTOP-38DMH77\\SQLEXPRESS;Database=AromaDom;Trusted_Connection=True;TrustServerCertificate=True";

        private const string MaterialsQuery =
            "SELECT m.Id, m.MaterialTypeId, mt.Name, m.Name, m.UnitPrice, m.Unit, " +
            "m.PackageQuantity, m.StockQuantity, m.MinQuantity " +
            "FROM Materials AS m " +
            "INNER JOIN MaterialTypes AS mt ON mt.Id = m.MaterialTypeId " +
            "ORDER BY m.Name";

        private const string MaterialUsagesQuery =
            "SELECT MaterialId, Quantity FROM MaterialProducts";

        public List<Material> GetMaterials()
        {
            List<Material> materials;
            Dictionary<int, List<decimal>> usagesByMaterial;

            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                connection.Open();
                materials = ReadMaterials(connection);
                usagesByMaterial = ReadMaterialUsages(connection);
            }

            foreach (Material material in materials)
            {
                List<decimal> quantities;

                if (!usagesByMaterial.TryGetValue(material.Id, out quantities))
                {
                    quantities = new List<decimal>();
                }

                material.RequiredQuantity = MaterialCalculator.CalculateRequiredQuantity(quantities);
            }

            return materials;
        }

        public List<MaterialType> GetMaterialTypes()
        {
            List<MaterialType> types = new List<MaterialType>();

            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                connection.Open();
                SqlCommand command = new SqlCommand("SELECT Id, Name FROM MaterialTypes ORDER BY Name", connection);

                using (SqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        types.Add(new MaterialType { Id = reader.GetInt32(0), Name = reader.GetString(1) });
                    }
                }
            }

            return types;
        }

        public List<MaterialProduct> GetProductsByMaterial(int materialId)
        {
            List<MaterialProduct> products = new List<MaterialProduct>();

            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                connection.Open();
                SqlCommand command = new SqlCommand("SELECT p.Article, p.Name, mp.Quantity FROM MaterialProducts mp " +
                    "JOIN Products p ON p.Id = mp.ProductId WHERE mp.MaterialId = @id ORDER BY p.Name", connection);
                command.Parameters.AddWithValue("@id", materialId);

                using (SqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        MaterialProduct product = new MaterialProduct();
                        product.Article = reader.GetString(0);
                        product.ProductName = reader.GetString(1);
                        product.Quantity = reader.GetDecimal(2);
                        products.Add(product);
                    }
                }
            }

            return products;
        }

        // если Id = 0 то это новый материал, иначе обновляем существующий
        public void SaveMaterial(Material material)
        {
            string query;

            if (material.Id == 0)
            {
                query = "INSERT INTO Materials (MaterialTypeId, Name, UnitPrice, Unit, PackageQuantity, StockQuantity, MinQuantity) " +
                    "VALUES (@typeId, @name, @price, @unit, @package, @stock, @min)";
            }
            else
            {
                query = "UPDATE Materials SET MaterialTypeId = @typeId, Name = @name, UnitPrice = @price, Unit = @unit, " +
                    "PackageQuantity = @package, StockQuantity = @stock, MinQuantity = @min WHERE Id = @id";
            }

            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                connection.Open();
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@typeId", material.MaterialTypeId);
                command.Parameters.AddWithValue("@name", material.Name);
                command.Parameters.AddWithValue("@price", material.UnitPrice);
                command.Parameters.AddWithValue("@unit", material.Unit);
                command.Parameters.AddWithValue("@package", material.PackageQuantity);
                command.Parameters.AddWithValue("@stock", material.StockQuantity);
                command.Parameters.AddWithValue("@min", material.MinQuantity);
                command.Parameters.AddWithValue("@id", material.Id);
                command.ExecuteNonQuery();
            }
        }

        private static List<Material> ReadMaterials(SqlConnection connection)
        {
            List<Material> materials = new List<Material>();

            using (SqlCommand command = new SqlCommand(MaterialsQuery, connection))
            using (SqlDataReader reader = command.ExecuteReader())
            {
                while (reader.Read())
                {
                    Material material = new Material
                    {
                        Id = reader.GetInt32(0),
                        MaterialTypeId = reader.GetInt32(1),
                        MaterialTypeName = reader.GetString(2),
                        Name = reader.GetString(3),
                        UnitPrice = reader.GetDecimal(4),
                        Unit = reader.GetString(5),
                        PackageQuantity = reader.GetDecimal(6),
                        StockQuantity = reader.GetDecimal(7),
                        MinQuantity = reader.GetDecimal(8)
                    };

                    materials.Add(material);
                }
            }

            return materials;
        }

        private static Dictionary<int, List<decimal>> ReadMaterialUsages(SqlConnection connection)
        {
            Dictionary<int, List<decimal>> usagesByMaterial = new Dictionary<int, List<decimal>>();

            using (SqlCommand command = new SqlCommand(MaterialUsagesQuery, connection))
            using (SqlDataReader reader = command.ExecuteReader())
            {
                while (reader.Read())
                {
                    int materialId = reader.GetInt32(0);
                    decimal quantity = reader.GetDecimal(1);

                    if (!usagesByMaterial.ContainsKey(materialId))
                    {
                        usagesByMaterial[materialId] = new List<decimal>();
                    }

                    usagesByMaterial[materialId].Add(quantity);
                }
            }

            return usagesByMaterial;
        }
    }
}
