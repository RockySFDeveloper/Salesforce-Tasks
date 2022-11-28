    public class OppAmountHandler {
        public virtual void addMoney ( String opName ) {
            Opportunity op;
            op = [SELECT Id, Name, Amount FROM Opportunity WHERE Name = :opName ];
            op.Amount = op.amount + 1000;
            Update op;
            system.debug(op);

        }

    }
