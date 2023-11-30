using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebTest.Models
{
    public class BaseModel
    {
        public BaseModel() 
        {
            CreatedAt = DateTime.UtcNow;
            UpdatedAt = DateTime.UtcNow;
        }
        public DateTime CreatedAt { get; set; }
        public DateTime UpdatedAt { get; set;}
    }
}