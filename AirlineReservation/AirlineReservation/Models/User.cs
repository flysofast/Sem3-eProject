//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace AirlineReservation.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class User
    {
        public User()
        {
            this.Tickets = new HashSet<Ticket>();
        }
    
        public string UserID { get; set; }
        public string Password { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public string PhoneNumber { get; set; }
        public bool Sex { get; set; }
        public string CreditcardNumber { get; set; }
        public System.DateTime DateOfBirth { get; set; }
        public bool IsAdmin { get; set; }
    
        public virtual ICollection<Ticket> Tickets { get; set; }
    }
}
