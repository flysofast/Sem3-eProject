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
    
    public partial class Seat
    {
        public Seat()
        {
            this.TakenSeats = new HashSet<TakenSeat>();
        }
    
        public string Class { get; set; }
        public string SeatID { get; set; }
    
        public virtual ICollection<TakenSeat> TakenSeats { get; set; }
    }
}
