//#pragma once

#include "..\\..\\IOS7Crypt.h"
#include "Muck.h"

namespace IOS7CryptGUI {
	using namespace System;
	using namespace System::ComponentModel;
	using namespace System::Collections;
	using namespace System::Windows::Forms;
	using namespace System::Data;
	using namespace System::Drawing;

	/// <summary>
	/// Summary for Form1
	///
	/// WARNING: If you change the name of this class, you will need to change the
	///          'Resource File Name' property for the managed resource compiler tool
	///          associated with all .resx files this class depends on.  Otherwise,
	///          the designers will not be able to interact properly with localized
	///          resources associated with this form.
	/// </summary>
	public ref class Form1: public System::Windows::Forms::Form {
	public:
		Form1(void) {
			InitializeComponent();
			//
			//TODO: Add the constructor code here
			//
		}

	protected:
		/// <summary>
		/// Clean up any resources being used.
		/// </summary>
		~Form1() {
			if (components) {
				delete components;
			}
		}
	private: System::Windows::Forms::Label^  passwordLabel;
	private: System::Windows::Forms::Label^  hashLabel;
	private: System::Windows::Forms::TextBox^  passwordBox;
	private: System::Windows::Forms::TextBox^  hashBox;

	private:
		/// <summary>
		/// Required designer variable.
		/// </summary>
		System::ComponentModel::Container ^components;

//#pragma region Windows Form Designer generated code

		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		void InitializeComponent(void) {
			System::ComponentModel::ComponentResourceManager^  resources = (gcnew System::ComponentModel::ComponentResourceManager(Form1::typeid));
			this->passwordLabel = (gcnew System::Windows::Forms::Label());
			this->hashLabel = (gcnew System::Windows::Forms::Label());
			this->passwordBox = (gcnew System::Windows::Forms::TextBox());
			this->hashBox = (gcnew System::Windows::Forms::TextBox());
			this->SuspendLayout();
			// 
			// passwordLabel
			// 
			this->passwordLabel->AutoSize = true;
			this->passwordLabel->Location = System::Drawing::Point(12, 15);
			this->passwordLabel->Name = L"passwordLabel";
			this->passwordLabel->Size = System::Drawing::Size(53, 13);
			this->passwordLabel->TabIndex = 0;
			this->passwordLabel->Text = L"Password";
			// 
			// hashLabel
			// 
			this->hashLabel->AutoSize = true;
			this->hashLabel->Location = System::Drawing::Point(12, 41);
			this->hashLabel->Name = L"hashLabel";
			this->hashLabel->Size = System::Drawing::Size(32, 13);
			this->hashLabel->TabIndex = 1;
			this->hashLabel->Text = L"Hash";
			// 
			// passwordBox
			// 
			this->passwordBox->Location = System::Drawing::Point(71, 12);
			this->passwordBox->Name = L"passwordBox";
			this->passwordBox->Size = System::Drawing::Size(100, 20);
			this->passwordBox->TabIndex = 2;
			this->passwordBox->KeyPress += gcnew System::Windows::Forms::KeyPressEventHandler(this, &Form1::passwordEntered);
			// 
			// hashBox
			// 
			this->hashBox->Location = System::Drawing::Point(71, 38);
			this->hashBox->Name = L"hashBox";
			this->hashBox->Size = System::Drawing::Size(100, 20);
			this->hashBox->TabIndex = 3;
			this->hashBox->KeyPress += gcnew System::Windows::Forms::KeyPressEventHandler(this, &Form1::hashEntered);
			// 
			// Form1
			// 
			this->AutoScaleDimensions = System::Drawing::SizeF(6, 13);
			this->AutoScaleMode = System::Windows::Forms::AutoScaleMode::Font;
			this->ClientSize = System::Drawing::Size(192, 76);
			this->Controls->Add(this->hashBox);
			this->Controls->Add(this->passwordBox);
			this->Controls->Add(this->hashLabel);
			this->Controls->Add(this->passwordLabel);
			this->Icon = (cli::safe_cast<System::Drawing::Icon^  >(resources->GetObject(L"$this.Icon")));
			this->MaximizeBox = false;
			this->MaximumSize = System::Drawing::Size(200, 110);
			this->MinimumSize = System::Drawing::Size(200, 110);
			this->Name = L"Form1";
			this->StartPosition = System::Windows::Forms::FormStartPosition::CenterScreen;
			this->Text = L"IOS7Crypt";
			this->ResumeLayout(false);
			this->PerformLayout();
		}

//#pragma endregion

		private: System::Void passwordEntered(System::Object^  sender, System::Windows::Forms::KeyPressEventArgs^  e) {
			if (e->KeyChar==(char) System::Windows::Forms::Keys::Enter) {
				std::string password=Muck::SysToStd(this->passwordBox->Text);
				std::string hash=IOS7Crypt::encrypt(password);

				this->hashBox->Text=Muck::StdToSys(hash);
			}
		}
		private: System::Void hashEntered(System::Object^  sender, System::Windows::Forms::KeyPressEventArgs^  e) {
			if (e->KeyChar==(char) System::Windows::Forms::Keys::Enter) {
				std::string hash=Muck::SysToStd(this->hashBox->Text);
				std::string password=IOS7Crypt::decrypt(hash);

				this->passwordBox->Text=Muck::StdToSys(password);
			}
		}
	};
}