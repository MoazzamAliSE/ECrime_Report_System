import 'package:ecrime/client/view/widgets/background_frame.dart';
import 'package:flutter/material.dart';

class WomenHelpPage extends StatelessWidget {
  final List<String> topics = [
    'Inheritance Rights',
    'Under -age & Forced Marriages',
    'More than one Marriages',
    'Nikkah Nama',
    'Laws for Women Protection',
    'General Safety Tips',
    'Women Development Achievements',
    'Women Ombudsperson Punjab',
    'Punjab Commission on the Status of Women',
  ];

  WomenHelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Women Help'),
          centerTitle: true,
        ),
        body: BackgroundFrame(
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            child: ListView.builder(
              itemCount: topics.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4, 
                  margin: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8), 
                  child: ListTile(
                    title: Text("${index + 1} ${topics[index]}"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              WomenHelpDetailPage(topic: topics[index]),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ));
  }
}

class WomenHelpDetailPage extends StatelessWidget {
  final String topic;

  const WomenHelpDetailPage({super.key, required this.topic});

  String getContent() {
    switch (topic) {
      case 'Inheritance Rights':
        return """
• To ensure the share of women in inheritance, distribution of property has been made mandatory after sanctioning mutation of inheritance [S.135 -A, 142 -A Land Revenue Act].

• It is mandatory to produce the NIC and Form B of the deceased and all his legal heirs, including women, before the revenue officer for the transfer of property.

• In case the legal heirs do not reach upon a consensus in 30 days, the concerned revenue officer will conduct the partition of property among legal heirs according to the law.

• It is mandatory for the revenue officer to decide the matter of inheritance within 6 months.

• The registration fee of mutation with respect to the transfer of inherited property of women has been abolished.

• District Enforcement of Inheritance Rights Committee has been established in every district to address and redress the grievance.

• Revenue staff is liable to be punished for negligence.

• Legal heirs can approach the concerned District Collector/DCO in case of a complaint.

""";

      case 'Under -age & Forced Marriages':
        return """
• Any person marrying a girl of less than 16 years of age and the person conducting such marriage, including the Nikkah Solemnizer and Nikkah Registrar, shall be liable for imprisonment up to 6 months and a fine of Rs: 50,000/ - [Punjab Child Marriage Restraint (amendment) Act 2015].

• Customs like Wanni and marriage in lieu of compromise or marriage with the Holy Quran are illegal, liable for imprisonment for 3 to 7 years and a fine of Rs: 500,000/ - [S.310 -A, 498 -C Pakistan Penal Code].

• A person forcibly marrying a girl against her will is liable to be punished with imprisonment for 3 to 7 years and a fine of Rs: 500,000/ - [S.498 -B Pakistan Penal Code].

• Complaints regarding underage marriage can be registered with Police/Union Council/Judicial Magistrate.

""";

      case 'More than one Marriages':
        return """
• Any person who enters into a second marriage without the permission of his first wife or arbitration council is liable to imprisonment for up to one year and a fine of up to PKR 500,000/ - [Polygamy 6(5)].

• A wife can consult the union council to demand her maintenance and that of her children from the husband. [Maintenance 9(A -1)]

""";
      case 'Nikkah Nama':
        return """
• It is obligatory for the Nikkah khawan/Registrar to read out to the groom and bride all the columns of Nikkah Nama and fill them according to their answers, violation whereof is liable to punishment of imprisonment for one month and a fine of PKR 25,000/ - [Registration of Marriages S.5(2A)].

• It is incumbent upon the Nikkah khawan and the person conducting marriage to have the nikkah registered, violation whereof is liable to punishment of imprisonment for three months and a fine of PKR 100,000/ - [Registration of Marriages S.5(4)].

""";

      case 'Laws for Women Protection':
        return """
• The Protection against Harassment of Women at Workplace Act, 2010, for the prevention and protection of women against harassment at the workplace.

• The Acid Control and Acid Crime Prevention Act, 2011 (Called Criminal Law (Second) Amendment Act, 2011) for the prevention of acid crimes and strict punishments.

• Prevention of Anti -Women Practices Act, 2011 (Criminal Law (Third Amendment) Act, 2011) for the prevention of customary practices such as giving a female in marriage or otherwise in badla -e sulh, wanni or swara, depriving women from inheriting property, forced marriages, and marriage of females with the Holy Quran.

• Protection of Women (Criminal Laws Amendment) Act, 2006 makes rape a criminal offense punishable with death or imprisonment for not less than ten years.

""";

      case 'General Safety Tips':
        return """
• Keep the least amount of money while shopping. Use plastic money (Debit/Credit card) as much as possible.

• Wear the least amount of jewelry while shopping.

• Always hang your purse through the neck at the front.

• Keep the vehicle doors locked while driving.

• Take necessary precautions while withdrawing a huge amount from the bank.

• Do not accept edibles from strangers, and also train the children about it.

• Do not allow strangers to enter home without identification.

• Make sure that NIC of your servant is attested by NADRA. Do not employ servants without identification.

• Do not leave small kids alone in the custody of single male/female servants.

• Train the kids to keep a distance from strangers.

""";

      case 'Women Development Achievements':
        return """
• Under the leadership of Mr. Shehbaz Sharif, the honorable Chief Minister Punjab, the women development department has taken a lot of initiatives in Punjab for legal and economic empowerment of women.

• Many more women development initiatives are in line with the vision of Mr. Shehbaz Sharif.

• Legal Empowerment:
 - As per amendment in Land Revenue Laws, women get facilitated accession of the title of property through inheritance.
 - Punjab Prevention of Violence Against Women Act 2016 has been promulgated.
 - Punjab Commission on the Status of Women Act 2014 has been promulgated and PCSW has been established.
 - Punjab Prevention of Harassment at Workplace Act 2012 has been promulgated, and the Office of Ombudsperson has been established.
 - Domestic Workers Policy has been approved by the Cabinet on December 17, 2015.
 - Construction of Family Court Complexes has been started in 10 districts, and land has been identified in 7 more districts.
 - Out of 709 police stations in the province, female help desks have been established in 680 police stations.

• Economic Empowerment:
 - Women Entrepreneurship: 4,80,218 women entrepreneurs were awarded loans amounting to Rs. 2.2 billion by Chief Minister Self -Employment Scheme.
 - Approximately 9000 Canteens in girls' schools all over Punjab are owned by women contractors.
 - 214 female colleges have canteens, of which 127 are operated by female contractors, and the rest of 87 canteens contracts will be awarded to women once the existing contracts end.

• Property Ownership:
 - 6000 Heifers and 6000 sheep/goats have been given to rural women.
 - 11000 plots have been allocated on equal ownership of husbands and wives in Jinnah Abadis.
 - Applications for the provision of 1000 scooties on easy terms will be called on March 8, 2016.

• Employment:
 - Women’s quota in public sector jobs has been increased from 5% to 15%.
 - Age limit for women job applicants has been increased by 3 years.
 - Women contractual employees have been allowed one additional transfer option.
 - Both parents are now entitled to maternity and paternity leave.
 - The power of sanctioning of maternity leave has been delegated on divisional level officers.
 - Punjab Day Care Fund Society funded 54 day care centers benefiting 1500 families.
 - Women Development Department has established 16 working women hostels across Punjab, 5000 women have benefitted from them in the last 2 years.

• Decision Making:
 - In 2969 trade unions of Punjab, 44517 women are serving as office bearers after amendment in Trade Union Act (Amendment) 2016.
 - 197 women in 63 boards of governors are serving as voting members after enactment of Punjab Fair Representation of Women Act 2014.

• Education:
 - PEEF has awarded scholarships to 85000 female students amounting to Rs. 4 billion.
 - PEF has awarded education vouchers to 100,000 female students.
 - 57 new female colleges’ construction was started, out of which 51 are completed.

• Vocational Trainings:
 - 120,000 women have been trained by PVTC.
 - More than 12000 women have been trained by TEVTA.
 - 1000 Domestic and Day Care workers have been trained by WDD.
 - 14,740 rural women have been trained by Punjab Skill Development Fund (PSDF).
 - 3070 rural women have been given veterinary training regarding livestock & poultry.

• Note: These trainings are being conducted since 2012.
""";

      case 'Women Ombudsperson Punjab':
        return """
• The office of the Ombudsperson is a resource for any female of the community with a problem or concern.

• It provides informal conflict resolution, mediation services, and advocacy for fair treatment and fair process.

• All the services provided are confidential.

• For details, contact:
 - Ombudsperson Punjab
 - 174 -Shadman -II, Lahore
 - Phone: 042 -99268281 -2

""";

      case 'Punjab Commission on the Status of Women':
        return """
• The Punjab Commission on the Status of Women (PCSW) is a statutory body established in February 2014 for the promotion of women's rights.

• After the devolution of women development to the provinces under the 18th amendment to the Constitution of Pakistan, PCSW was conceived as an oversight body to ensure policies and programs of the government promote gender equality in Punjab.

• A major objective of PCSW is the elimination of all forms of discrimination against women.

• For further details, please visit.

""";

      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(topic),
      ),
      body: BackgroundFrame(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Details for $topic:',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(getContent()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
