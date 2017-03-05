package com.example.administrator.postbar;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity {

    private Button signin_bt;
    private EditText user_name_et,user_password_et;
    private CharSequence user_name,user_password;
    private TextView register_enter;
    interface Checkpassword {
        void checkpassword(CharSequence user_name,CharSequence user_password);
    }
    class Client implements Checkpassword {
        public void checkpassword(CharSequence user_name,CharSequence user_password) {
            //这里写后台登录接口方法
        }
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        user_name_et = (EditText)findViewById(R.id.editText);
        user_password_et = (EditText)findViewById(R.id.editText2);
        signin_bt = (Button)findViewById(R.id.button_signin);
        register_enter = (TextView)findViewById(R.id.textView_register);
        signin_bt.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                user_password = user_password_et.getText();
                user_name = user_name_et.getText();
                new Client().checkpassword(user_name,user_password);
            }
        });

        register_enter.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent_register = new Intent(MainActivity.this,register.class);
                startActivity(intent_register);
            }
        });
    }
}
