using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace WebTest.Models
{
    public class Order : BaseModel
    {
       
        [Key]
        public int Id { get; set; }
        public int AccountId { get; set; }
        public List<ProductLine> ProductLines { get; set; }    
        public decimal Subtotal { get; set; }
        public decimal Taxes { get; set; }
        public decimal Total { get; set; }

        public Order() 
        {
            ProductLines = new List<ProductLine>();
        }
    }
}