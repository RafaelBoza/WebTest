using System;
using System.Data.Entity;
using System.Linq;
using WebTest.Models;

namespace WebTest
{
    public class MyContext : DbContext
    {
        // El contexto se ha configurado para usar una cadena de conexión 'Model1' del archivo 
        // de configuración de la aplicación (App.config o Web.config). De forma predeterminada, 
        // esta cadena de conexión tiene como destino la base de datos 'WebTest.Model1' de la instancia LocalDb. 
        // 
        // Si desea tener como destino una base de datos y/o un proveedor de base de datos diferente, 
        // modifique la cadena de conexión 'Model1'  en el archivo de configuración de la aplicación.
        public MyContext()
            : base("name=Database1ConnectionString")
        {
        }

        // Agregue un DbSet para cada tipo de entidad que desee incluir en el modelo. Para obtener más información 
        // sobre cómo configurar y usar un modelo Code First, vea http://go.microsoft.com/fwlink/?LinkId=390109.

         public virtual DbSet<Item> Items { get; set; }
         public virtual DbSet<Account> Accounts { get; set; }
         public virtual DbSet<Order> Orders { get; set; }
         public virtual DbSet<ProductLine> ProductLines { get; set; }
         public virtual DbSet<State> States { get; set; }
    }

    
}