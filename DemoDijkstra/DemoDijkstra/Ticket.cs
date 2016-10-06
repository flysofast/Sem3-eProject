//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace DemoDijkstra
{
    using System;
    using System.Collections.Generic;
    
    public partial class Ticket
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Ticket()
        {
            this.TakenSeats = new HashSet<TakenSeat>();
            this.Ticket_Flight = new HashSet<Ticket_Flight>();
        }
    
        public string TicketNo { get; set; }
        public string UserID { get; set; }
        public string ConfirmationNo { get; set; }
        public string BlockNo { get; set; }
        public string CancellationNo { get; set; }
        public decimal Price { get; set; }
        public System.DateTime CreatedDate { get; set; }
        public Nullable<int> NumberOfAdults { get; set; }
        public Nullable<int> NumberOfChildren { get; set; }
        public Nullable<int> NumberOfSeniorCitizens { get; set; }
        public int Status { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<TakenSeat> TakenSeats { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Ticket_Flight> Ticket_Flight { get; set; }
        public virtual User User { get; set; }
    }
}