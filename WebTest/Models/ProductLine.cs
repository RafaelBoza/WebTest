using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Diagnostics;
using System.Linq;
using System.Web;

namespace WebTest.Models
{
    public class ProductLine : BaseModel
    {
        [Key]
        public int Id { get; set; }
        public int OrderId { get; set; }
        public int ItemId { get; set; } 
        public int Qty { get; set; }        
        public decimal Amount { get; set; }        

        public ProductLine() { Qty = 1; }
        
    }
}