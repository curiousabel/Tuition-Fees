/*
 * Program:         Tuition
 * Module:          tuition-fees.xml , Tuition.xslt
 * Date:            <2018-06-17>
 * Author:          <Abel>
 * Description:     Complete a console application in C# that uses an XML document for data storage
 *                   and uses XSLT and XPath to generate formatted reports based on the XML data.
 * Purpose: 
 *                   The intention is to apply the following XML technologies:
 *                      1. Transforming/formatting XML data using XSLT
 */

using System;
using System.Collections.Generic;
using System.IO;
using System.Linq; 
using System.Text;
using System.Threading.Tasks;
using System.Xml;
using System.Xml.XPath;
using System.Xml.Xsl;

namespace Project2
{
    class Program
    {

        // Member constants
        private const string _XML_FILE = @"C:\Users\abelb\Desktop\Fanshawe CPA_04\Programming with XML\Project2\Project2\tuition-fees.xml";
        private const string XSLT_FILE_IN = @"C:\Users\abelb\Desktop\Fanshawe CPA_04\Programming with XML\Project2\Project2\Tuition.xslt";
        private static XmlDocument _doc = null;
        private XPathDocument xpDoc = null;

        static void Main(string[] args)
        {
            generateCode();
        }
        public static void generateCode()
        {
            try
            {
                //transfrom 
                XslCompiledTransform xslt = new XslCompiledTransform();
                   xslt.Load(XSLT_FILE_IN);
                // parameter list creator 
                XsltArgumentList xsltArgList = new XsltArgumentList();

                //TItle
                Console.WriteLine("Canadian Undergraduate Tuition Fees");
                Console.WriteLine("------------------------------------");
                Console.Write("Enter either 'R' to select a region or 'F' to select to a field-of-study : ");
                string selectionInput = Console.ReadLine();

                // options 
                if (selectionInput.ToUpper() == "R")
                {
                    // Load XML file into the DOM
                    _doc = new XmlDocument();
                    _doc.Load(_XML_FILE);
                    XmlNodeList xcode = _doc.SelectNodes("//region");
                    foreach (XmlNode c in xcode)
                    {
                        Console.Write(c.Attributes.GetNamedItem("code").InnerText + "  ");
                        Console.WriteLine(c.Attributes.GetNamedItem("description").InnerText);
                    }
                       Console.Write("Enter a region#: ");
                    //send the value enter to the xslt
                    xsltArgList.AddParam("user-selected-region", "", Console.ReadLine());

                }

                else if (selectionInput.ToUpper() == "F")
                {

                    // Load XML file into the DOM
                    _doc = new XmlDocument();
                    _doc.Load(_XML_FILE);
                    XmlNodeList xcode = _doc.SelectNodes("//field");
                    foreach (XmlNode c in xcode)
                    {
                        Console.Write(c.Attributes.GetNamedItem("code").InnerText + "  ");
                        Console.WriteLine(c.Attributes.GetNamedItem("description").InnerText);
                    }
                    Console.Write("Enter a Field#: ");

                    //send the value enter to the xslt
                    xsltArgList.AddParam("user-selected-field", "", Console.ReadLine());

                }


                // ouptut to the html 
                string outputFile = @"..\..\index.html";
                FileStream fileStream = File.Create(outputFile);
                xslt.Transform(_doc, xsltArgList, fileStream);

            }
            catch (Exception e)
            {
                Console.WriteLine(e);

            }

        }
        }

       
        }

    


