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
    
    public partial class Route
    {
        public Route()
        {
            this.Flights = new HashSet<Flight>();
        }
    
        public int RouteID { get; set; }
        public string OriginalCityID { get; set; }
        public string DestinationCityID { get; set; }
        public int Distance { get; set; }
        public bool InService { get; set; }
    
        public virtual City OriginalCity { get; set; }
        public virtual City DestinationCity { get; set; }
        public virtual ICollection<Flight> Flights { get; set; }
    }
}
