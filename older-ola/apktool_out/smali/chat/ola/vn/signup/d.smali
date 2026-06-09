.class public Lchat/ola/vn/signup/d;
.super Lchat/ola/vn/signup/a;

# interfaces
.implements Landroid/app/DatePickerDialog$OnDateSetListener;
.implements Landroid/view/View$OnClickListener;


# instance fields
.field private a:Landroid/widget/EditText;

.field private b:Landroid/view/animation/Animation;

.field private c:Landroid/view/View;

.field private d:Landroid/widget/RadioGroup;

.field private e:Landroid/widget/Button;

.field private f:Landroid/widget/Button;

.field private g:Landroid/widget/Button;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/signup/a;-><init>()V

    return-void
.end method

.method private a(Landroid/view/View;)V
    .locals 5

    const v0, 0x7f090373

    :try_start_0
    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/signup/d;->c:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/signup/d;->c:Landroid/view/View;

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    sget-object v0, Lchat/ola/vn/signup/OlaSignUpActivity;->j:Ljava/lang/Long;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    const/4 v1, 0x1

    if-eqz v0, :cond_0

    :try_start_1
    invoke-static {}, Ljava/util/Calendar;->getInstance()Ljava/util/Calendar;

    move-result-object v0

    sget-object v2, Lchat/ola/vn/signup/OlaSignUpActivity;->j:Ljava/lang/Long;

    invoke-virtual {v2}, Ljava/lang/Long;->longValue()J

    move-result-wide v2

    invoke-virtual {v0, v2, v3}, Ljava/util/Calendar;->setTimeInMillis(J)V

    iget-object v2, p0, Lchat/ola/vn/signup/d;->e:Landroid/widget/Button;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, ""

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const/4 v4, 0x5

    invoke-virtual {v0, v4}, Ljava/util/Calendar;->get(I)I

    move-result v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    iget-object v2, p0, Lchat/ola/vn/signup/d;->f:Landroid/widget/Button;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, ""

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const/4 v4, 0x2

    invoke-virtual {v0, v4}, Ljava/util/Calendar;->get(I)I

    move-result v4

    add-int/2addr v4, v1

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    iget-object v2, p0, Lchat/ola/vn/signup/d;->g:Landroid/widget/Button;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, ""

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, v1}, Ljava/util/Calendar;->get(I)I

    move-result v0

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :cond_0
    :try_start_2
    sget-byte v0, Lchat/ola/vn/signup/OlaSignUpActivity;->l:B

    packed-switch v0, :pswitch_data_0

    return-void

    :pswitch_0
    const v0, 0x7f09021e

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    :goto_0
    check-cast p1, Landroid/widget/RadioButton;

    invoke-virtual {p1, v1}, Landroid/widget/RadioButton;->setChecked(Z)V

    return-void

    :pswitch_1
    const v0, 0x7f090327

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    goto :goto_0

    :pswitch_2
    const v0, 0x7f090211

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    goto :goto_0

    :catch_1
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private y()V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/signup/d;->a:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->isFocused()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/signup/d;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/signup/d;->a:Landroid/widget/EditText;

    const/4 v2, 0x0

    invoke-static {v0, v1, v2}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;Landroid/view/View;Z)V

    iget-object v0, p0, Lchat/ola/vn/signup/d;->a:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->clearFocus()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method


# virtual methods
.method public a(ILjava/lang/String;[B[Lchat/ola/vn/entity/d;S)V
    .locals 0

    const/4 p3, 0x2

    if-eq p1, p3, :cond_0

    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_1

    invoke-virtual {p0}, Lchat/ola/vn/signup/d;->j()Lchat/ola/vn/signup/OlaSignUpActivity;

    move-result-object p1

    const p3, 0x7f0f0280

    invoke-virtual {p0, p3}, Lchat/ola/vn/signup/d;->getString(I)Ljava/lang/String;

    move-result-object p3

    invoke-static {p1, p3, p2}, Lchat/ola/vn/i/i;->b(Landroid/content/Context;Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/app/Dialog;

    return-void

    :cond_0
    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/signup/d;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    const p2, 0x7f0f0269

    invoke-static {p1, p2}, Lchat/ola/vn/util/j;->d(Landroid/content/Context;I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method

.method protected b(Landroid/os/Bundle;)V
    .locals 0

    invoke-super {p0, p1}, Lchat/ola/vn/signup/a;->b(Landroid/os/Bundle;)V

    return-void
.end method

.method public c()Lchat/ola/vn/signup/a;
    .locals 2

    :try_start_0
    sget-object v0, Lchat/ola/vn/signup/OlaSignUpActivity;->m:Ljava/lang/String;

    if-eqz v0, :cond_0

    sget-object v0, Lchat/ola/vn/signup/OlaSignUpActivity;->k:[B

    if-eqz v0, :cond_1

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/signup/d;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    const-class v1, Lchat/ola/vn/signup/e;

    invoke-virtual {v1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/support/v4/app/Fragment;->instantiate(Landroid/content/Context;Ljava/lang/String;)Landroid/support/v4/app/Fragment;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/signup/e;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    :cond_1
    const/4 v0, 0x0

    return-object v0
.end method

.method public e()Ljava/lang/String;
    .locals 1

    const v0, 0x7f0f042c

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public e_()Ljava/lang/String;
    .locals 1

    const v0, 0x7f0f06c5

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public h()Ljava/lang/String;
    .locals 1

    sget-object v0, Lchat/ola/vn/signup/OlaSignUpActivity;->m:Ljava/lang/String;

    if-nez v0, :cond_0

    const v0, 0x7f0f0574

    :goto_0
    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v0

    return-object v0

    :cond_0
    const v0, 0x7f0f04f5

    goto :goto_0
.end method

.method public onClick(Landroid/view/View;)V
    .locals 7

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const v0, 0x7f0901db

    if-eq p1, v0, :cond_1

    const v0, 0x7f09035f

    if-eq p1, v0, :cond_1

    const v0, 0x7f090373

    if-eq p1, v0, :cond_0

    const v0, 0x7f090614

    if-eq p1, v0, :cond_1

    return-void

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/signup/d;->x()V

    return-void

    :cond_1
    invoke-direct {p0}, Lchat/ola/vn/signup/d;->y()V

    new-instance p1, Landroid/app/DatePickerDialog;

    invoke-virtual {p0}, Lchat/ola/vn/signup/d;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v2

    const/16 v4, 0x7d0

    const/4 v5, 0x5

    const/16 v6, 0xf

    move-object v1, p1

    move-object v3, p0

    invoke-direct/range {v1 .. v6}, Landroid/app/DatePickerDialog;-><init>(Landroid/content/Context;Landroid/app/DatePickerDialog$OnDateSetListener;III)V

    invoke-virtual {p1}, Landroid/app/DatePickerDialog;->show()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 0
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "NewApi"
        }
    .end annotation

    sget-object p2, Lchat/ola/vn/signup/OlaSignUpActivity;->m:Ljava/lang/String;

    const/4 p3, 0x0

    if-eqz p2, :cond_1

    sget-object p2, Lchat/ola/vn/signup/OlaSignUpActivity;->k:[B

    if-eqz p2, :cond_0

    goto :goto_0

    :cond_0
    const p2, 0x7f0b016d

    goto :goto_1

    :cond_1
    :goto_0
    const p2, 0x7f0b016c

    :goto_1
    invoke-virtual {p1, p2, p3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p1

    const p2, 0x7f09023d

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/EditText;

    iput-object p2, p0, Lchat/ola/vn/signup/d;->a:Landroid/widget/EditText;

    const p2, 0x7f090241

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/RadioGroup;

    iput-object p2, p0, Lchat/ola/vn/signup/d;->d:Landroid/widget/RadioGroup;

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/signup/d;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p2

    invoke-static {p2}, Lchat/ola/vn/util/n;->g(Landroid/content/Context;)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p3

    if-nez p3, :cond_2

    iget-object p3, p0, Lchat/ola/vn/signup/d;->a:Landroid/widget/EditText;

    invoke-virtual {p3, p2}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_2

    :catch_0
    move-exception p2

    invoke-virtual {p2}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_2
    :goto_2
    invoke-virtual {p0}, Lchat/ola/vn/signup/d;->j()Lchat/ola/vn/signup/OlaSignUpActivity;

    move-result-object p2

    const p3, 0x7f010042

    invoke-static {p2, p3}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object p2

    iput-object p2, p0, Lchat/ola/vn/signup/d;->b:Landroid/view/animation/Animation;

    const p2, 0x7f0901db

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/Button;

    iput-object p2, p0, Lchat/ola/vn/signup/d;->e:Landroid/widget/Button;

    iget-object p2, p0, Lchat/ola/vn/signup/d;->e:Landroid/widget/Button;

    invoke-virtual {p2, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p2, 0x7f09035f

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/Button;

    iput-object p2, p0, Lchat/ola/vn/signup/d;->f:Landroid/widget/Button;

    iget-object p2, p0, Lchat/ola/vn/signup/d;->f:Landroid/widget/Button;

    invoke-virtual {p2, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p2, 0x7f090614

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/Button;

    iput-object p2, p0, Lchat/ola/vn/signup/d;->g:Landroid/widget/Button;

    iget-object p2, p0, Lchat/ola/vn/signup/d;->g:Landroid/widget/Button;

    invoke-virtual {p2, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p2, 0x7f090373

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    iput-object p2, p0, Lchat/ola/vn/signup/d;->c:Landroid/view/View;

    iget-object p2, p0, Lchat/ola/vn/signup/d;->c:Landroid/view/View;

    invoke-virtual {p2, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    invoke-direct {p0, p1}, Lchat/ola/vn/signup/d;->a(Landroid/view/View;)V

    return-object p1
.end method

.method public onDateSet(Landroid/widget/DatePicker;III)V
    .locals 4

    :try_start_0
    invoke-static {}, Ljava/util/Calendar;->getInstance()Ljava/util/Calendar;

    move-result-object p1

    const/4 v0, 0x5

    invoke-virtual {p1, v0, p4}, Ljava/util/Calendar;->set(II)V

    const/4 v0, 0x2

    invoke-virtual {p1, v0, p3}, Ljava/util/Calendar;->set(II)V

    const/4 v0, 0x1

    invoke-virtual {p1, v0, p2}, Ljava/util/Calendar;->set(II)V

    iget-object v1, p0, Lchat/ola/vn/signup/d;->e:Landroid/widget/Button;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, ""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, p4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p4

    invoke-virtual {v1, p4}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    iget-object p4, p0, Lchat/ola/vn/signup/d;->f:Landroid/widget/Button;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, ""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    add-int/2addr p3, v0

    invoke-virtual {v1, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p3

    invoke-virtual {p4, p3}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    iget-object p3, p0, Lchat/ola/vn/signup/d;->g:Landroid/widget/Button;

    new-instance p4, Ljava/lang/StringBuilder;

    invoke-direct {p4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, ""

    invoke-virtual {p4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p4, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {p4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p3, p2}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    invoke-virtual {p1}, Ljava/util/Calendar;->getTimeInMillis()J

    move-result-wide p1

    invoke-static {p1, p2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p1

    sput-object p1, Lchat/ola/vn/signup/OlaSignUpActivity;->j:Ljava/lang/Long;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public x()V
    .locals 13

    iget-object v0, p0, Lchat/ola/vn/signup/d;->a:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lchat/ola/vn/signup/OlaSignUpActivity;->g:Ljava/lang/String;

    iget-object v0, p0, Lchat/ola/vn/signup/d;->d:Landroid/widget/RadioGroup;

    invoke-virtual {v0}, Landroid/widget/RadioGroup;->getCheckedRadioButtonId()I

    move-result v0

    const v1, 0x7f090211

    const/4 v2, 0x0

    const/4 v3, 0x1

    if-eq v0, v1, :cond_2

    const v1, 0x7f09021e

    const/4 v4, 0x2

    if-eq v0, v1, :cond_0

    const v1, 0x7f090327

    if-eq v0, v1, :cond_1

    :cond_0
    sput-byte v4, Lchat/ola/vn/signup/OlaSignUpActivity;->l:B

    goto :goto_0

    :cond_1
    sput-byte v3, Lchat/ola/vn/signup/OlaSignUpActivity;->l:B

    goto :goto_0

    :cond_2
    sput-byte v2, Lchat/ola/vn/signup/OlaSignUpActivity;->l:B

    :goto_0
    sget-object v0, Lchat/ola/vn/signup/OlaSignUpActivity;->j:Ljava/lang/Long;

    if-nez v0, :cond_3

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    sput-object v0, Lchat/ola/vn/signup/OlaSignUpActivity;->j:Ljava/lang/Long;

    :cond_3
    sget-object v0, Lchat/ola/vn/signup/OlaSignUpActivity;->m:Ljava/lang/String;

    if-eqz v0, :cond_5

    sget-object v0, Lchat/ola/vn/signup/OlaSignUpActivity;->k:[B

    if-eqz v0, :cond_4

    goto :goto_1

    :cond_4
    invoke-virtual {p0}, Lchat/ola/vn/signup/d;->j()Lchat/ola/vn/signup/OlaSignUpActivity;

    move-result-object v0

    invoke-virtual {v0, v3}, Lchat/ola/vn/signup/OlaSignUpActivity;->c(Z)V

    sget-object v4, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    sget-object v5, Lchat/ola/vn/signup/OlaSignUpActivity;->e:Ljava/lang/String;

    sget-object v6, Lchat/ola/vn/signup/OlaSignUpActivity;->f:Ljava/lang/String;

    sget-object v7, Lchat/ola/vn/signup/OlaSignUpActivity;->m:Ljava/lang/String;

    sget-object v8, Lchat/ola/vn/signup/OlaSignUpActivity;->g:Ljava/lang/String;

    sget-object v9, Lchat/ola/vn/signup/OlaSignUpActivity;->i:Ljava/lang/String;

    sget-object v10, Lchat/ola/vn/signup/OlaSignUpActivity;->j:Ljava/lang/Long;

    sget-byte v11, Lchat/ola/vn/signup/OlaSignUpActivity;->l:B

    const/4 v12, 0x0

    invoke-virtual/range {v4 .. v12}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Long;BS)V

    return-void

    :cond_5
    :goto_1
    sget-object v0, Lchat/ola/vn/signup/OlaSignUpActivity;->k:[B

    if-nez v0, :cond_6

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0, v2}, Lchat/ola/vn/network/OlaNetworkService;->i(S)V

    :cond_6
    iget-object v0, p0, Lchat/ola/vn/signup/d;->a:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lchat/ola/vn/signup/OlaSignUpActivity;->g:Ljava/lang/String;

    invoke-virtual {p0}, Lchat/ola/vn/signup/d;->j()Lchat/ola/vn/signup/OlaSignUpActivity;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/signup/OlaSignUpActivity;->B()V

    return-void
.end method
