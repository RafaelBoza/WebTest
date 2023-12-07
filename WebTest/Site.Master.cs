﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebTest.Models;

namespace WebTest
{
    public partial class SiteMaster : MasterPage
    {
        MyContext context;
        protected void Page_Load(object sender, EventArgs e)
        {
            context = new MyContext();
            //preload with some States
            if (!context.States.Any())
            {
                var state1 = new State
                {
                    Name = "Republic of Cuba",
                    Id = "CUB"
                };
                var state2 = new State
                {
                    Name = "United States of America",
                    Id = "USA"
                };
                var state3 = new State
                {
                    Name = "France",
                    Id = "FRA"
                };
                context.States.Add(state1);
                context.States.Add(state2);
                context.States.Add(state3);
                context.SaveChanges();
            }

            //Preload with some Acccounts
            if (!context.Accounts.Any())
            {
                var cuenta = new Account
                {
                    Name = "Etecsa",
                    StateId = "CUB"

                };
                var cuenta1 = new Account
                {
                    Name = "Cubacel",
                    StateId = "CUB"
                };
                var cuenta2 = new Account
                {
                    Name = "Mobitel",
                    StateId = "USA"
                };
                context.Accounts.Add(cuenta);
                context.Accounts.Add(cuenta1);
                context.Accounts.Add(cuenta2);
                context.SaveChanges();
            }
            //Preload with some Products
            if (!context.Items.Any())
            {
                var item1 = new Item
                {
                    Name = "Arroz",
                    Price = 10
                };

                var item2 = new Item
                {
                    Name = "Frijoles",
                    Price = 15
                };

                var item3 = new Item
                {
                    Name = "Carne",
                    Price = 20
                };

                var item4 = new Item
                {
                    Name = "Pollo",
                    Price = 25
                };

                var item5 = new Item
                {
                    Name = "Condimento",
                    Price = 30
                };
                var item10 = new Item
                {
                    Name = "Lentejas",
                    Price = 10
                };

                var item6 = new Item
                {
                    Name = "Azucar",
                    Price = 15
                };

                var item7 = new Item
                {
                    Name = "Leche",
                    Price = 20
                };

                var item8 = new Item
                {
                    Name = "Sal",
                    Price = 25
                };

                var item9 = new Item
                {
                    Name = "Agua Mineral",
                    Price = 30
                };

                context.Items.Add(item1);
                context.Items.Add(item2);
                context.Items.Add(item3);
                context.Items.Add(item4);
                context.Items.Add(item5);
                context.Items.Add(item6);
                context.Items.Add(item7);
                context.Items.Add(item8);
                context.Items.Add(item9);
                context.Items.Add(item10);
                context.SaveChanges();
            }
        }
    }
}