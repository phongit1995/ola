.class public Lchat/ola/vn/activity/OlaPhoneVerificationActivity;
.super Lchat/ola/vn/c;

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Lchat/ola/vn/sms/a$a;


# instance fields
.field private e:Landroid/widget/EditText;

.field private f:Landroid/view/View;

.field private g:Lchat/ola/vn/sms/a;

.field private h:Landroid/view/View;

.field private i:Landroid/view/View;

.field private j:Landroid/widget/TextView;

.field private k:Landroid/widget/CheckBox;

.field private l:Ljava/lang/Runnable;

.field private m:Ljava/lang/String;

.field private n:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/c;-><init>()V

    return-void
.end method

.method private B()V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->e:Landroid/widget/EditText;

    const/4 v1, 0x0

    invoke-static {p0, v0, v1}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;Landroid/view/View;Z)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :try_start_1
    iget-object v0, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->e:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_1

    invoke-static {v0}, Lchat/ola/vn/util/o;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x1

    invoke-virtual {p0, v1}, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->c(Z)V

    sget-object v1, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    iget-object v1, v1, Lchat/ola/vn/entity/ag;->f:Ljava/lang/String;

    invoke-static {v0, v1}, Lchat/ola/vn/util/o;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    const/4 v2, 0x0

    invoke-virtual {v1, v2, v0, v2, v2}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Long;Ljava/lang/Byte;)V

    return-void

    :cond_0
    invoke-direct {p0}, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->C()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    :cond_1
    return-void
.end method

.method private C()V
    .locals 1

    new-instance v0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity$2;

    invoke-direct {v0, p0}, Lchat/ola/vn/activity/OlaPhoneVerificationActivity$2;-><init>(Lchat/ola/vn/activity/OlaPhoneVerificationActivity;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method private D()V
    .locals 1

    new-instance v0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity$3;

    invoke-direct {v0, p0}, Lchat/ola/vn/activity/OlaPhoneVerificationActivity$3;-><init>(Lchat/ola/vn/activity/OlaPhoneVerificationActivity;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/activity/OlaPhoneVerificationActivity;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->m:Ljava/lang/String;

    return-object p1
.end method

.method public static a(Landroid/content/Context;)V
    .locals 0

    invoke-static {p0}, Lchat/ola/vn/activity/OlaPhoneVerifyByAccountKitActivity;->a(Landroid/content/Context;)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/activity/OlaPhoneVerificationActivity;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->B()V

    return-void
.end method

.method static synthetic b(Lchat/ola/vn/activity/OlaPhoneVerificationActivity;)Landroid/widget/CheckBox;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->k:Landroid/widget/CheckBox;

    return-object p0
.end method

.method static synthetic b(Lchat/ola/vn/activity/OlaPhoneVerificationActivity;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->n:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic c(Lchat/ola/vn/activity/OlaPhoneVerificationActivity;)Landroid/view/View;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->f:Landroid/view/View;

    return-object p0
.end method

.method private f(Ljava/lang/String;)V
    .locals 1

    :try_start_0
    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object p1, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->e:Landroid/widget/EditText;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->e:Landroid/widget/EditText;

    invoke-static {p1}, Lchat/ola/vn/util/o;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method


# virtual methods
.method protected a()V
    .locals 0

    return-void
.end method

.method public c(Z)V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->f:Landroid/view/View;

    if-eqz p1, :cond_0

    const/4 v1, 0x0

    goto :goto_0

    :cond_0
    const/16 v1, 0x8

    :goto_0
    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->l:Ljava/lang/Runnable;

    if-nez v0, :cond_1

    new-instance v0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity$4;

    invoke-direct {v0, p0}, Lchat/ola/vn/activity/OlaPhoneVerificationActivity$4;-><init>(Lchat/ola/vn/activity/OlaPhoneVerificationActivity;)V

    iput-object v0, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->l:Ljava/lang/Runnable;

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->l:Ljava/lang/Runnable;

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->c(Ljava/lang/Runnable;)V

    if-eqz p1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->l:Ljava/lang/Runnable;

    const-wide/32 v0, 0xea60

    invoke-static {p1, v0, v1}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;J)V

    :cond_2
    return-void
.end method

.method public f(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    :try_start_0
    new-instance v0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity$5;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/activity/OlaPhoneVerificationActivity$5;-><init>(Lchat/ola/vn/activity/OlaPhoneVerificationActivity;Ljava/lang/String;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    new-instance v0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity$6;

    invoke-direct {v0, p0, p1, p2}, Lchat/ola/vn/activity/OlaPhoneVerificationActivity$6;-><init>(Lchat/ola/vn/activity/OlaPhoneVerificationActivity;Ljava/lang/String;Ljava/lang/String;)V

    const-wide/16 p1, 0x3e8

    invoke-static {v0, p1, p2}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;J)V

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object p2

    const/4 v0, 0x0

    invoke-virtual {p1, p2, v0}, Lchat/ola/vn/network/OlaNetworkService;->b(Ljava/lang/String;S)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public finish()V
    .locals 2

    invoke-super {p0}, Lchat/ola/vn/c;->finish()V

    const v0, 0x7f01003a

    const v1, 0x7f01003b

    :try_start_0
    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->overridePendingTransition(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public m()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->C()V

    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 1

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const v0, 0x7f09039c

    if-eq p1, v0, :cond_0

    packed-switch p1, :pswitch_data_0

    return-void

    :pswitch_0
    invoke-direct {p0}, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->B()V

    return-void

    :pswitch_1
    invoke-direct {p0}, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->D()V

    return-void

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->finish()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x7f0903c7
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 4

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    const p1, 0x7f0b0164

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->setContentView(I)V

    const p1, 0x7f0903ea

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->f:Landroid/view/View;

    const p1, 0x7f0903a3

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    const v0, 0x7f0f068e

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(I)V

    const p1, 0x7f09039c

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    const v0, 0x7f0f044d

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(I)V

    invoke-virtual {p1, p0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f0903a4

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f0903c9

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->j:Landroid/widget/TextView;

    const p1, 0x7f090141

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/CheckBox;

    iput-object p1, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->k:Landroid/widget/CheckBox;

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->k:Landroid/widget/CheckBox;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->k:Landroid/widget/CheckBox;

    const v1, 0x7f0f032a

    invoke-virtual {p0, v1}, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lchat/ola/vn/util/i;->a(Landroid/view/View;Ljava/lang/String;)Ljava/lang/CharSequence;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/CheckBox;->setText(Ljava/lang/CharSequence;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    const p1, 0x7f0903c8

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->h:Landroid/view/View;

    iget-object p1, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->h:Landroid/view/View;

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f0903c7

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->i:Landroid/view/View;

    iget-object p1, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->i:Landroid/view/View;

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f0903c2

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/EditText;

    iput-object p1, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->e:Landroid/widget/EditText;

    :try_start_1
    iget-object p1, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->h:Landroid/view/View;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    sget-object p1, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    iget-short p1, p1, Lchat/ola/vn/entity/ag;->u:S

    const/16 v1, 0x8

    if-gtz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->k:Landroid/widget/CheckBox;

    invoke-virtual {p1, v0}, Landroid/widget/CheckBox;->setVisibility(I)V

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->k:Landroid/widget/CheckBox;

    invoke-virtual {p1, v1}, Landroid/widget/CheckBox;->setVisibility(I)V

    :goto_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->i:Landroid/view/View;

    invoke-virtual {p1, v1}, Landroid/view/View;->setVisibility(I)V

    sget-object p1, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    iget-object p1, p1, Lchat/ola/vn/entity/ag;->f:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    const v2, 0x7f0f0244

    const/4 v3, 0x1

    if-nez p1, :cond_3

    sget-object p1, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    iget-object p1, p1, Lchat/ola/vn/entity/ag;->f:Ljava/lang/String;

    invoke-direct {p0, p1}, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->f(Ljava/lang/String;)V

    sget-object p1, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    iget-boolean p1, p1, Lchat/ola/vn/entity/ag;->B:Z

    if-eqz p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->e:Landroid/widget/EditText;

    invoke-virtual {p1, v0}, Landroid/widget/EditText;->setEnabled(Z)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->h:Landroid/view/View;

    invoke-virtual {p1, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->k:Landroid/widget/CheckBox;

    invoke-virtual {p1, v1}, Landroid/widget/CheckBox;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->i:Landroid/view/View;

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->j:Landroid/widget/TextView;

    const v0, 0x7f0f037c

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(I)V

    goto :goto_4

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->e:Landroid/widget/EditText;

    invoke-virtual {p1, v3}, Landroid/widget/EditText;->setEnabled(Z)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->h:Landroid/view/View;

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    sget-object p1, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    iget-short p1, p1, Lchat/ola/vn/entity/ag;->u:S

    if-gtz p1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->k:Landroid/widget/CheckBox;

    invoke-virtual {p1, v0}, Landroid/widget/CheckBox;->setVisibility(I)V

    goto :goto_1

    :cond_2
    iget-object p1, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->k:Landroid/widget/CheckBox;

    invoke-virtual {p1, v1}, Landroid/widget/CheckBox;->setVisibility(I)V

    :goto_1
    iget-object p1, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->i:Landroid/view/View;

    invoke-virtual {p1, v1}, Landroid/view/View;->setVisibility(I)V

    :goto_2
    iget-object p1, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->j:Landroid/widget/TextView;

    invoke-virtual {p1, v2}, Landroid/widget/TextView;->setText(I)V

    goto :goto_4

    :cond_3
    sget-object p1, Lchat/ola/vn/h;->S:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_5

    sget-object p1, Lchat/ola/vn/h;->S:Ljava/lang/String;

    invoke-direct {p0, p1}, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->f(Ljava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->e:Landroid/widget/EditText;

    invoke-virtual {p1, v3}, Landroid/widget/EditText;->setEnabled(Z)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->h:Landroid/view/View;

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    sget-object p1, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    iget-short p1, p1, Lchat/ola/vn/entity/ag;->u:S

    if-gtz p1, :cond_4

    iget-object p1, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->k:Landroid/widget/CheckBox;

    invoke-virtual {p1, v0}, Landroid/widget/CheckBox;->setVisibility(I)V

    goto :goto_3

    :cond_4
    iget-object p1, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->k:Landroid/widget/CheckBox;

    invoke-virtual {p1, v1}, Landroid/widget/CheckBox;->setVisibility(I)V

    :goto_3
    iget-object p1, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->i:Landroid/view/View;

    invoke-virtual {p1, v1}, Landroid/view/View;->setVisibility(I)V

    goto :goto_2

    :cond_5
    iget-object p1, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->e:Landroid/widget/EditText;

    const-string v0, ""

    invoke-virtual {p1, v0}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    :goto_4
    iget-object p1, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->e:Landroid/widget/EditText;

    new-instance v0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity$1;

    invoke-direct {v0, p0}, Lchat/ola/vn/activity/OlaPhoneVerificationActivity$1;-><init>(Lchat/ola/vn/activity/OlaPhoneVerificationActivity;)V

    invoke-virtual {p1, v0}, Landroid/widget/EditText;->setOnEditorActionListener(Landroid/widget/TextView$OnEditorActionListener;)V

    :try_start_2
    new-instance p1, Lchat/ola/vn/sms/a;

    invoke-direct {p1}, Lchat/ola/vn/sms/a;-><init>()V

    iput-object p1, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->g:Lchat/ola/vn/sms/a;

    iget-object p1, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->g:Lchat/ola/vn/sms/a;

    invoke-virtual {p1, p0}, Lchat/ola/vn/sms/a;->a(Lchat/ola/vn/sms/a$a;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->g:Lchat/ola/vn/sms/a;

    new-instance v0, Landroid/content/IntentFilter;

    const-string v1, "android.provider.Telephony.SMS_RECEIVED"

    invoke-direct {v0, v1}, Landroid/content/IntentFilter;-><init>(Ljava/lang/String;)V

    invoke-virtual {p0, p1, v0}, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    :catch_2
    return-void
.end method

.method protected onDestroy()V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->g:Lchat/ola/vn/sms/a;

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :try_start_1
    iget-object v0, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->l:Ljava/lang/Runnable;

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->c(Ljava/lang/Runnable;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    invoke-super {p0}, Lchat/ola/vn/c;->onDestroy()V

    return-void
.end method

.method public onRequestPermissionsResult(I[Ljava/lang/String;[I)V
    .locals 3

    const/16 p2, 0x6a

    const/4 v0, 0x0

    if-ne p1, p2, :cond_3

    const/4 p1, 0x0

    const/4 p2, 0x0

    :goto_0
    :try_start_0
    array-length v1, p3

    if-ge p2, v1, :cond_1

    aget v1, p3, p2

    if-eqz v1, :cond_0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->m:Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->n:Ljava/lang/String;

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->c(Z)V

    const p1, 0x7f0f00a2

    const p2, 0x7f0f0332

    invoke-static {p0, p1, p2}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;II)Landroid/app/Dialog;

    return-void

    :cond_0
    add-int/lit8 p2, p2, 0x1

    goto :goto_0

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->m:Ljava/lang/String;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->n:Ljava/lang/String;

    invoke-static {p0, p1, p2}, Lchat/ola/vn/sms/b;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->n:Ljava/lang/String;

    const-string p2, "MGM XT"

    invoke-virtual {p1, p2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_2

    invoke-static {}, Lchat/ola/vn/util/f;->a()Lchat/ola/vn/util/f;

    move-result-object p1

    const-string p2, "Verify phone number"

    invoke-virtual {p1, p2}, Lchat/ola/vn/util/f;->c(Ljava/lang/String;)V

    goto :goto_1

    :cond_2
    iget-object p1, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->n:Ljava/lang/String;

    const-string p2, "MGM BUYVIP"

    invoke-virtual {p1, p2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_3

    const/16 p1, 0xfa0

    invoke-static {}, Lchat/ola/vn/util/f;->a()Lchat/ola/vn/util/f;

    move-result-object p2

    const-string p3, "Buy VIP and Verify"

    int-to-long v1, p1

    invoke-virtual {p2, p3, v1, v2}, Lchat/ola/vn/util/f;->a(Ljava/lang/String;J)V

    :cond_3
    :goto_1
    iput-object v0, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->m:Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->n:Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
