import scala.xml.XML

val hive_df = spark.sql("select * from default.customer_test")
val projDF = hive_df.select("CustomerID","Demographics")

case class CustomerDemo(CustomerID: Int, TotalPurchaseYTD: String, DateFirstPurchase : String, BirthDate : String, MaritalStatus : String, YearlyIncome : String, Gender : String, TotalChildren : String, NumberChildrenAtHome : String, Education : String, Occupation : String, HomeOwnerFlag : String, NumberCarsOwned : String, CommuteDistance : String) extends java.io.Serializable

def createCustDemo(custId: Int, demo:String) : CustomerDemo = {
	val node = XML.loadString(demo)
	CustomerDemo(
		custId,
		(node \\ "IndividualSurvey" \\ "TotalPurchaseYTD").text,
		(node \\ "IndividualSurvey" \\ "DateFirstPurchase").text,
		(node \\ "IndividualSurvey" \\ "BirthDate").text,
		(node \\ "IndividualSurvey" \\ "MaritalStatus").text,
		(node \\ "IndividualSurvey" \\ "YearlyIncome").text,
		(node \\ "IndividualSurvey" \\ "Gender").text,
		(node \\ "IndividualSurvey" \\ "TotalChildren").text,
		(node \\ "IndividualSurvey" \\ "NumberChildrenAtHome").text,
		(node \\ "IndividualSurvey" \\ "Education").text,
		(node \\ "IndividualSurvey" \\ "Occupation").text,
		(node \\ "IndividualSurvey" \\ "HomeOwnerFlag").text,
		(node \\ "IndividualSurvey" \\ "NumberCarsOwned").text,
		(node \\ "IndividualSurvey" \\ "CommuteDistance").text
	)
}
val projRDD = projDF.map(r => createCustDemo(r.get(0).toString.toInt, r.get(1).toString))

projRDD.toDF.write.format("parquet").mode("append").save("customer_demographics_xml_mined")


