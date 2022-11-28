public class OppAmountSubClass extends OppAmountHandler {
    public static void gettingOpp() {
        OppAmountHandler xy = new OppAmountSubClass();
        xy.multiplyMoney('GenePoint SLA');
        System.debug(xy);

    }
}
