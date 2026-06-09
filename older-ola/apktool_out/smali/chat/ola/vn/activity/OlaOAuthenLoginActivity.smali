.class public Lchat/ola/vn/activity/OlaOAuthenLoginActivity;
.super Landroid/accounts/AccountAuthenticatorActivity;

# interfaces
.implements Landroid/view/View$OnClickListener;


# instance fields
.field private a:Landroid/widget/EditText;

.field private b:Landroid/widget/EditText;

.field private c:Landroid/app/Dialog;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Landroid/accounts/AccountAuthenticatorActivity;-><init>()V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/activity/OlaOAuthenLoginActivity;Landroid/app/Dialog;)Landroid/app/Dialog;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaOAuthenLoginActivity;->c:Landroid/app/Dialog;

    return-object p1
.end method

.method private a()V
    .locals 4

    iget-object v0, p0, Lchat/ola/vn/activity/OlaOAuthenLoginActivity;->c:Landroid/app/Dialog;

    if-eqz v0, :cond_0

    return-void

    :cond_0
    const v0, 0x7f0f01fa

    const-wide/32 v1, 0xea60

    new-instance v3, Lchat/ola/vn/activity/OlaOAuthenLoginActivity$2;

    invoke-direct {v3, p0}, Lchat/ola/vn/activity/OlaOAuthenLoginActivity$2;-><init>(Lchat/ola/vn/activity/OlaOAuthenLoginActivity;)V

    invoke-static {p0, v0, v1, v2, v3}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;IJLjava/lang/Runnable;)Lchat/ola/vn/i/c;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaOAuthenLoginActivity;->c:Landroid/app/Dialog;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaOAuthenLoginActivity;->a:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/activity/OlaOAuthenLoginActivity;->b:Landroid/widget/EditText;

    invoke-virtual {v1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Lchat/ola/vn/activity/OlaOAuthenLoginActivity$3;

    invoke-direct {v2, p0, v0, v1}, Lchat/ola/vn/activity/OlaOAuthenLoginActivity$3;-><init>(Lchat/ola/vn/activity/OlaOAuthenLoginActivity;Ljava/lang/String;Ljava/lang/String;)V

    const/4 v0, 0x0

    new-array v0, v0, [Ljava/lang/Void;

    invoke-virtual {v2, v0}, Lchat/ola/vn/activity/OlaOAuthenLoginActivity$3;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;

    return-void
.end method

.method private a(Landroid/content/Intent;)V
    .locals 10

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaOAuthenLoginActivity;->c:Landroid/app/Dialog;

    invoke-virtual {v0}, Landroid/app/Dialog;->dismiss()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    const/4 v0, 0x0

    :try_start_1
    iput-object v0, p0, Lchat/ola/vn/activity/OlaOAuthenLoginActivity;->c:Landroid/app/Dialog;

    const v1, 0x7f0f0268

    const v2, 0x7f0f009f

    if-eqz p1, :cond_0

    const-string v3, "_result"

    const/4 v4, 0x1

    invoke-virtual {p1, v3, v4}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v3

    if-eq v3, v4, :cond_2

    const/16 v0, 0x21

    if-eq v3, v0, :cond_1

    const-string v0, "_byte_data"

    invoke-virtual {p1, v0}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    invoke-virtual {p0, v2}, Lchat/ola/vn/activity/OlaOAuthenLoginActivity;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, v0, p1}, Lchat/ola/vn/i/i;->b(Landroid/content/Context;Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/app/Dialog;

    return-void

    :cond_0
    invoke-static {p0, v2, v1}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;II)Landroid/app/Dialog;

    return-void

    :cond_1
    const p1, 0x7f0f01fc

    invoke-static {p0, v2, p1}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;II)Landroid/app/Dialog;

    return-void

    :cond_2
    const-string v1, "authAccount"

    invoke-virtual {p1, v1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    const-string v2, "_pass"

    invoke-virtual {p1, v2}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    const-string v3, "authtoken"

    invoke-virtual {p1, v3}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    new-instance v4, Landroid/accounts/Account;

    const-string v5, "accountType"

    invoke-virtual {p1, v5}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-direct {v4, v1, v5}, Landroid/accounts/Account;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-static {p0}, Landroid/accounts/AccountManager;->get(Landroid/content/Context;)Landroid/accounts/AccountManager;

    move-result-object v1

    const-string v5, "_time"

    const-wide/16 v6, 0x0

    invoke-virtual {p1, v5, v6, v7}, Landroid/content/Intent;->getLongExtra(Ljava/lang/String;J)J

    move-result-wide v5

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaOAuthenLoginActivity;->getIntent()Landroid/content/Intent;

    move-result-object v7

    const-string v8, "ARG_IS_ADDING_NEW_ACCOUNT"

    const/4 v9, 0x0

    invoke-virtual {v7, v8, v9}, Landroid/content/Intent;->getBooleanExtra(Ljava/lang/String;Z)Z

    move-result v7

    const v8, 0x7f0f06e9

    if-eqz v7, :cond_3

    invoke-virtual {p0, v8}, Lchat/ola/vn/activity/OlaOAuthenLoginActivity;->getString(I)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v1, v4, v2, v0}, Landroid/accounts/AccountManager;->addAccountExplicitly(Landroid/accounts/Account;Ljava/lang/String;Landroid/os/Bundle;)Z

    invoke-virtual {v1, v4, v7, v3}, Landroid/accounts/AccountManager;->setAuthToken(Landroid/accounts/Account;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "_time"

    invoke-static {v5, v6}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v2

    :goto_0
    invoke-virtual {v1, v4, v0, v2}, Landroid/accounts/AccountManager;->setUserData(Landroid/accounts/Account;Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_1

    :cond_3
    invoke-virtual {p0, v8}, Lchat/ola/vn/activity/OlaOAuthenLoginActivity;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v4, v0, v3}, Landroid/accounts/AccountManager;->setAuthToken(Landroid/accounts/Account;Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v1, v4, v2}, Landroid/accounts/AccountManager;->setPassword(Landroid/accounts/Account;Ljava/lang/String;)V

    const-string v0, "_time"

    invoke-static {v5, v6}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v2

    goto :goto_0

    :goto_1
    invoke-virtual {p1}, Landroid/content/Intent;->getExtras()Landroid/os/Bundle;

    move-result-object v0

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaOAuthenLoginActivity;->setAccountAuthenticatorResult(Landroid/os/Bundle;)V

    const/4 v0, -0x1

    invoke-virtual {p0, v0, p1}, Lchat/ola/vn/activity/OlaOAuthenLoginActivity;->setResult(ILandroid/content/Intent;)V

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaOAuthenLoginActivity;->finish()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    return-void

    :catch_1
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/activity/OlaOAuthenLoginActivity;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaOAuthenLoginActivity;->a()V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/activity/OlaOAuthenLoginActivity;Landroid/content/Intent;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/activity/OlaOAuthenLoginActivity;->a(Landroid/content/Intent;)V

    return-void
.end method

.method static synthetic b(Lchat/ola/vn/activity/OlaOAuthenLoginActivity;)Landroid/app/Dialog;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaOAuthenLoginActivity;->c:Landroid/app/Dialog;

    return-object p0
.end method


# virtual methods
.method protected onActivityResult(IILandroid/content/Intent;)V
    .locals 0

    const/4 p1, -0x1

    if-ne p2, p1, :cond_0

    if-eqz p3, :cond_0

    const-string p1, "_username"

    invoke-virtual {p3, p1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    const-string p2, "_pass"

    invoke-virtual {p3, p2}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    iget-object p3, p0, Lchat/ola/vn/activity/OlaOAuthenLoginActivity;->a:Landroid/widget/EditText;

    invoke-virtual {p3, p1}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaOAuthenLoginActivity;->b:Landroid/widget/EditText;

    invoke-virtual {p1, p2}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaOAuthenLoginActivity;->a()V

    :cond_0
    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 1

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const v0, 0x7f0900a0

    if-eq p1, v0, :cond_2

    const v0, 0x7f0900dd

    if-eq p1, v0, :cond_1

    const v0, 0x7f090111

    if-eq p1, v0, :cond_0

    return-void

    :cond_0
    new-instance p1, Landroid/content/Intent;

    const-class v0, Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity;

    invoke-direct {p1, p0, v0}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Lchat/ola/vn/activity/OlaOAuthenLoginActivity;->startActivityForResult(Landroid/content/Intent;I)V

    return-void

    :cond_1
    invoke-direct {p0}, Lchat/ola/vn/activity/OlaOAuthenLoginActivity;->a()V

    return-void

    :cond_2
    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaOAuthenLoginActivity;->finish()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 1

    invoke-super {p0, p1}, Landroid/accounts/AccountAuthenticatorActivity;->onCreate(Landroid/os/Bundle;)V

    const p1, 0x7f0b001b

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaOAuthenLoginActivity;->setContentView(I)V

    const p1, 0x7f0905a0

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaOAuthenLoginActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/EditText;

    iput-object p1, p0, Lchat/ola/vn/activity/OlaOAuthenLoginActivity;->a:Landroid/widget/EditText;

    iget-object p1, p0, Lchat/ola/vn/activity/OlaOAuthenLoginActivity;->a:Landroid/widget/EditText;

    invoke-virtual {p1, p0}, Landroid/widget/EditText;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f090576

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaOAuthenLoginActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/EditText;

    iput-object p1, p0, Lchat/ola/vn/activity/OlaOAuthenLoginActivity;->b:Landroid/widget/EditText;

    iget-object p1, p0, Lchat/ola/vn/activity/OlaOAuthenLoginActivity;->b:Landroid/widget/EditText;

    invoke-virtual {p1, p0}, Landroid/widget/EditText;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaOAuthenLoginActivity;->b:Landroid/widget/EditText;

    new-instance v0, Lchat/ola/vn/activity/OlaOAuthenLoginActivity$1;

    invoke-direct {v0, p0}, Lchat/ola/vn/activity/OlaOAuthenLoginActivity$1;-><init>(Lchat/ola/vn/activity/OlaOAuthenLoginActivity;)V

    invoke-virtual {p1, v0}, Landroid/widget/EditText;->setOnEditorActionListener(Landroid/widget/TextView$OnEditorActionListener;)V

    const p1, 0x7f0900dd

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaOAuthenLoginActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f090111

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaOAuthenLoginActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f0900a0

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaOAuthenLoginActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    return-void
.end method

.method public onCreateOptionsMenu(Landroid/view/Menu;)Z
    .locals 2

    invoke-super {p0, p1}, Landroid/accounts/AccountAuthenticatorActivity;->onCreateOptionsMenu(Landroid/view/Menu;)Z

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaOAuthenLoginActivity;->getMenuInflater()Landroid/view/MenuInflater;

    move-result-object v0

    const/high16 v1, 0x7f0c0000

    invoke-virtual {v0, v1, p1}, Landroid/view/MenuInflater;->inflate(ILandroid/view/Menu;)V

    const/4 p1, 0x1

    return p1
.end method

.method public onOptionsItemSelected(Landroid/view/MenuItem;)Z
    .locals 2

    invoke-interface {p1}, Landroid/view/MenuItem;->getItemId()I

    move-result v0

    const v1, 0x102002c

    if-ne v0, v1, :cond_0

    invoke-static {p0}, Landroid/support/v4/app/NavUtils;->navigateUpFromSameTask(Landroid/app/Activity;)V

    const/4 p1, 0x1

    return p1

    :cond_0
    invoke-super {p0, p1}, Landroid/accounts/AccountAuthenticatorActivity;->onOptionsItemSelected(Landroid/view/MenuItem;)Z

    move-result p1

    return p1
.end method
