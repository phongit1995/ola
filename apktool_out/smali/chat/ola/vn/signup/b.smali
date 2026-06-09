.class public Lchat/ola/vn/signup/b;
.super Lchat/ola/vn/signup/a;

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Lchat/ola/vn/countrypicker/c;


# instance fields
.field private a:Landroid/widget/EditText;

.field private b:Landroid/widget/TextView;

.field private c:Landroid/widget/TextView;

.field private d:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lchat/ola/vn/countrypicker/a;",
            ">;"
        }
    .end annotation
.end field

.field private e:Landroid/widget/TextView;

.field private f:Landroid/view/animation/Animation;

.field private g:Landroid/view/View;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/signup/a;-><init>()V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/signup/b;)Landroid/widget/TextView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/signup/b;->b:Landroid/widget/TextView;

    return-object p0
.end method

.method private a(Landroid/content/Context;)V
    .locals 4

    :try_start_0
    invoke-static {}, Lchat/ola/vn/activity/OlaBottomTabActivity;->y()Ljava/lang/String;

    move-result-object v0

    const-string v1, "VN"

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object p1, p0, Lchat/ola/vn/signup/b;->c:Landroid/widget/TextView;

    const-string v0, "VN"

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/signup/b;->b:Landroid/widget/TextView;

    const-string v0, "+84"

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto/16 :goto_1

    :cond_0
    invoke-static {}, Lchat/ola/vn/activity/OlaBottomTabActivity;->y()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-virtual {p0}, Lchat/ola/vn/signup/b;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;->a(Landroid/content/Context;)Ljava/util/Map;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/signup/b;->d:Ljava/util/Map;

    iget-object p1, p0, Lchat/ola/vn/signup/b;->d:Ljava/util/Map;

    if-eqz p1, :cond_4

    iget-object p1, p0, Lchat/ola/vn/signup/b;->c:Landroid/widget/TextView;

    invoke-static {}, Lchat/ola/vn/activity/OlaBottomTabActivity;->y()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/signup/b;->d:Ljava/util/Map;

    invoke-static {}, Lchat/ola/vn/activity/OlaBottomTabActivity;->y()Ljava/lang/String;

    move-result-object v0

    invoke-interface {p1, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/countrypicker/a;

    invoke-virtual {p1}, Lchat/ola/vn/countrypicker/a;->c()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_4

    iget-object v0, p0, Lchat/ola/vn/signup/b;->b:Landroid/widget/TextView;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "+"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_1
    const-string v0, "phone"

    invoke-virtual {p1, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/telephony/TelephonyManager;

    invoke-virtual {p1}, Landroid/telephony/TelephonyManager;->getSimCountryIso()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    const/4 v2, 0x2

    if-eqz v0, :cond_2

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v3

    if-ne v3, v2, :cond_2

    sget-object p1, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v0, p1}, Ljava/lang/String;->toUpperCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v1

    goto :goto_0

    :cond_2
    invoke-virtual {p1}, Landroid/telephony/TelephonyManager;->getPhoneType()I

    move-result v0

    if-eq v0, v2, :cond_3

    invoke-virtual {p1}, Landroid/telephony/TelephonyManager;->getNetworkCountryIso()Ljava/lang/String;

    move-result-object p1

    if-eqz p1, :cond_3

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-ne v0, v2, :cond_3

    sget-object v0, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {p1, v0}, Ljava/lang/String;->toUpperCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v1

    :cond_3
    :goto_0
    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_4

    invoke-virtual {p0}, Lchat/ola/vn/signup/b;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;->a(Landroid/content/Context;)Ljava/util/Map;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/signup/b;->d:Ljava/util/Map;

    iget-object p1, p0, Lchat/ola/vn/signup/b;->d:Ljava/util/Map;

    if-eqz p1, :cond_4

    iget-object p1, p0, Lchat/ola/vn/signup/b;->c:Landroid/widget/TextView;

    invoke-virtual {p1, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/signup/b;->d:Ljava/util/Map;

    invoke-interface {p1, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/countrypicker/a;

    invoke-virtual {p1}, Lchat/ola/vn/countrypicker/a;->c()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_4

    iget-object v0, p0, Lchat/ola/vn/signup/b;->b:Landroid/widget/TextView;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "+"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_4
    :goto_1
    iget-object p1, p0, Lchat/ola/vn/signup/b;->c:Landroid/widget/TextView;

    const-string v0, "VN"

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/signup/b;->b:Landroid/widget/TextView;

    const-string v0, "+84"

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    iget-object p1, p0, Lchat/ola/vn/signup/b;->c:Landroid/widget/TextView;

    const-string v0, "VN"

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/signup/b;->b:Landroid/widget/TextView;

    const-string v0, "+84"

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void
.end method

.method private a(Landroid/view/View;)V
    .locals 2

    const v0, 0x7f0903c2

    :try_start_0
    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    iput-object v0, p0, Lchat/ola/vn/signup/b;->a:Landroid/widget/EditText;

    iget-object v0, p0, Lchat/ola/vn/signup/b;->a:Landroid/widget/EditText;

    new-instance v1, Lchat/ola/vn/signup/b$1;

    invoke-direct {v1, p0}, Lchat/ola/vn/signup/b$1;-><init>(Lchat/ola/vn/signup/b;)V

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->addTextChangedListener(Landroid/text/TextWatcher;)V

    iget-object v0, p0, Lchat/ola/vn/signup/b;->a:Landroid/widget/EditText;

    new-instance v1, Lchat/ola/vn/signup/b$2;

    invoke-direct {v1, p0}, Lchat/ola/vn/signup/b$2;-><init>(Lchat/ola/vn/signup/b;)V

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setOnEditorActionListener(Landroid/widget/TextView$OnEditorActionListener;)V

    const v0, 0x7f0901d0

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/signup/b;->c:Landroid/widget/TextView;

    const v0, 0x7f0903c6

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/signup/b;->e:Landroid/widget/TextView;

    invoke-virtual {p0}, Lchat/ola/vn/signup/b;->j()Lchat/ola/vn/signup/OlaSignUpActivity;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/n;->b(Landroid/content/Context;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/signup/b;->e:Landroid/widget/TextView;

    const v1, 0x7f0f05a8

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/signup/b;->e:Landroid/widget/TextView;

    const v1, 0x7f0f05a7

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    :goto_0
    const v0, 0x7f0901cf

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/signup/b;->b:Landroid/widget/TextView;

    const v0, 0x7f090373

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/signup/b;->g:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/signup/b;->c:Landroid/widget/TextView;

    const-string v1, "VN"

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/signup/b;->c:Landroid/widget/TextView;

    invoke-virtual {v0, p0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/signup/b;->b:Landroid/widget/TextView;

    const-string v1, "+84"

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/signup/b;->g:Landroid/view/View;

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/signup/b;->b:Landroid/widget/TextView;

    invoke-virtual {v0, p0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f090066

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    invoke-static {}, Lchat/ola/vn/activity/OlaBottomTabActivity;->x()Z

    move-result p1

    if-eqz p1, :cond_1

    sget-object p1, Lchat/ola/vn/h;->S:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/signup/b;->a:Landroid/widget/EditText;

    sget-object v0, Lchat/ola/vn/h;->S:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method

.method static synthetic b(Lchat/ola/vn/signup/b;)Landroid/widget/EditText;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/signup/b;->a:Landroid/widget/EditText;

    return-object p0
.end method

.method static synthetic c(Lchat/ola/vn/signup/b;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/signup/b;->z()V

    return-void
.end method

.method private e(Ljava/lang/String;)Z
    .locals 2

    :try_start_0
    sget-object v0, Landroid/util/Patterns;->PHONE:Ljava/util/regex/Pattern;

    invoke-virtual {v0, p1}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/regex/Matcher;->find()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-virtual {v0}, Ljava/util/regex/Matcher;->start()I

    move-result v1

    if-nez v1, :cond_0

    invoke-virtual {v0}, Ljava/util/regex/Matcher;->end()I

    move-result v0

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    if-ne v0, p1, :cond_0

    const/4 p1, 0x1

    return p1

    :catch_0
    :cond_0
    const/4 p1, 0x0

    return p1
.end method

.method private y()V
    .locals 6

    iget-object v0, p0, Lchat/ola/vn/signup/b;->d:Ljava/util/Map;

    if-nez v0, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/signup/b;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;->a(Landroid/content/Context;)Ljava/util/Map;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/signup/b;->d:Ljava/util/Map;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/signup/b;->a:Landroid/widget/EditText;

    const-string v1, ""

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/signup/b;->d:Ljava/util/Map;

    if-eqz v0, :cond_2

    const-string v0, ""

    iget-object v1, p0, Lchat/ola/vn/signup/b;->d:Ljava/util/Map;

    invoke-interface {v1}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_1
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_2

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/countrypicker/a;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "+"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Lchat/ola/vn/countrypicker/a;->c()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_1

    iget-object v1, p0, Lchat/ola/vn/signup/b;->c:Landroid/widget/TextView;

    invoke-virtual {v2}, Lchat/ola/vn/countrypicker/a;->a()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v1, p0, Lchat/ola/vn/signup/b;->b:Landroid/widget/TextView;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "+"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Lchat/ola/vn/countrypicker/a;->c()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v1, p0, Lchat/ola/vn/signup/b;->a:Landroid/widget/EditText;

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v2

    invoke-virtual {v0, v2}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/signup/b;->c:Landroid/widget/TextView;

    const-string v1, "VN"

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/signup/b;->b:Landroid/widget/TextView;

    const-string v1, "+84"

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void
.end method

.method private z()V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/signup/b;->a:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :goto_0
    :try_start_1
    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    const-string v1, "0"

    invoke-virtual {v0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v1
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    move-object v0, v1

    goto :goto_0

    :catch_0
    :cond_0
    :try_start_2
    invoke-static {}, Lchat/ola/vn/activity/OlaBottomTabActivity;->x()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    iget-object v0, p0, Lchat/ola/vn/signup/b;->a:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->requestFocus()Z

    iget-object v0, p0, Lchat/ola/vn/signup/b;->a:Landroid/widget/EditText;

    iget-object v1, p0, Lchat/ola/vn/signup/b;->f:Landroid/view/animation/Animation;

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->startAnimation(Landroid/view/animation/Animation;)V

    iget-object v0, p0, Lchat/ola/vn/signup/b;->e:Landroid/widget/TextView;

    sget v1, Lchat/ola/vn/f;->k:I

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v0, p0, Lchat/ola/vn/signup/b;->e:Landroid/widget/TextView;

    const v1, 0x7f0f0257

    invoke-virtual {p0, v1}, Lchat/ola/vn/signup/b;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_1
    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_3

    const-string v1, "+"

    invoke-virtual {v0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_2

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v2, p0, Lchat/ola/vn/signup/b;->b:Landroid/widget/TextView;

    invoke-virtual {v2}, Landroid/widget/TextView;->getText()Ljava/lang/CharSequence;

    move-result-object v2

    invoke-interface {v2}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    :cond_2
    invoke-direct {p0, v0}, Lchat/ola/vn/signup/b;->e(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_3

    iget-object v0, p0, Lchat/ola/vn/signup/b;->a:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->requestFocus()Z

    iget-object v0, p0, Lchat/ola/vn/signup/b;->a:Landroid/widget/EditText;

    iget-object v1, p0, Lchat/ola/vn/signup/b;->f:Landroid/view/animation/Animation;

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->startAnimation(Landroid/view/animation/Animation;)V

    iget-object v0, p0, Lchat/ola/vn/signup/b;->e:Landroid/widget/TextView;

    sget v1, Lchat/ola/vn/f;->k:I

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v0, p0, Lchat/ola/vn/signup/b;->e:Landroid/widget/TextView;

    const v1, 0x7f0f0258

    invoke-virtual {p0, v1}, Lchat/ola/vn/signup/b;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_3
    sput-object v0, Lchat/ola/vn/signup/OlaSignUpActivity;->h:Ljava/lang/String;

    invoke-virtual {p0}, Lchat/ola/vn/signup/b;->j()Lchat/ola/vn/signup/OlaSignUpActivity;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/signup/OlaSignUpActivity;->B()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    return-void
.end method


# virtual methods
.method public a(ILjava/lang/String;[B[Lchat/ola/vn/entity/d;S)V
    .locals 0

    const/4 p2, 0x4

    if-eq p1, p2, :cond_0

    return-void

    :cond_0
    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/signup/b;->e:Landroid/widget/TextView;

    const/4 p2, 0x0

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/signup/b;->e:Landroid/widget/TextView;

    sget p2, Lchat/ola/vn/f;->k:I

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object p1, p0, Lchat/ola/vn/signup/b;->e:Landroid/widget/TextView;

    const p2, 0x7f0f0258

    invoke-virtual {p0, p2}, Lchat/ola/vn/signup/b;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(Lchat/ola/vn/countrypicker/a;)V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/signup/b;->c:Landroid/widget/TextView;

    invoke-virtual {p1}, Lchat/ola/vn/countrypicker/a;->a()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/signup/b;->b:Landroid/widget/TextView;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "+"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Lchat/ola/vn/countrypicker/a;->c()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/signup/b;->b:Landroid/widget/TextView;

    invoke-virtual {p1}, Landroid/widget/TextView;->getText()Ljava/lang/CharSequence;

    move-result-object p1

    invoke-interface {p1}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/signup/b;->a:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {p1, v0}, Lchat/ola/vn/util/m;->g(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    sput-object p1, Lchat/ola/vn/signup/OlaSignUpActivity;->h:Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method protected b(Landroid/os/Bundle;)V
    .locals 0

    invoke-super {p0, p1}, Lchat/ola/vn/signup/a;->b(Landroid/os/Bundle;)V

    sget-object p1, Lchat/ola/vn/signup/OlaSignUpActivity;->h:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_0

    sget-object p1, Lchat/ola/vn/h;->S:Ljava/lang/String;

    sput-object p1, Lchat/ola/vn/signup/OlaSignUpActivity;->h:Ljava/lang/String;

    :cond_0
    sget-object p1, Lchat/ola/vn/signup/OlaSignUpActivity;->h:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_1

    invoke-direct {p0}, Lchat/ola/vn/signup/b;->y()V

    return-void

    :cond_1
    invoke-virtual {p0}, Lchat/ola/vn/signup/b;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    invoke-direct {p0, p1}, Lchat/ola/vn/signup/b;->a(Landroid/content/Context;)V

    return-void
.end method

.method public c()Lchat/ola/vn/signup/a;
    .locals 2

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/signup/b;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    const-class v1, Lchat/ola/vn/signup/c;

    invoke-virtual {v1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/support/v4/app/Fragment;->instantiate(Landroid/content/Context;Ljava/lang/String;)Landroid/support/v4/app/Fragment;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/signup/a;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public e()Ljava/lang/String;
    .locals 1

    const/4 v0, 0x0

    return-object v0
.end method

.method public e_()Ljava/lang/String;
    .locals 1

    const v0, 0x7f0f05dc

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public h()Ljava/lang/String;
    .locals 1

    const v0, 0x7f0f0574

    :try_start_0
    invoke-virtual {p0, v0}, Lchat/ola/vn/signup/b;->getString(I)Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public onClick(Landroid/view/View;)V
    .locals 6

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    sparse-switch p1, :sswitch_data_0

    return-void

    :sswitch_0
    invoke-direct {p0}, Lchat/ola/vn/signup/b;->z()V

    return-void

    :sswitch_1
    iget-object p1, p0, Lchat/ola/vn/signup/b;->d:Ljava/util/Map;

    if-nez p1, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/signup/b;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;->a(Landroid/content/Context;)Ljava/util/Map;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/signup/b;->d:Ljava/util/Map;

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/signup/b;->d:Ljava/util/Map;

    if-eqz p1, :cond_2

    sput-object p0, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;->e:Lchat/ola/vn/countrypicker/c;

    invoke-virtual {p0}, Lchat/ola/vn/signup/b;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;->b(Landroid/content/Context;)V

    return-void

    :sswitch_2
    iget-object p1, p0, Lchat/ola/vn/signup/b;->a:Landroid/widget/EditText;

    invoke-virtual {p1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_1

    invoke-virtual {p0}, Lchat/ola/vn/signup/b;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    const v1, 0x7f0f041f

    const v2, 0x7f0f0420

    const v3, 0x7f0f048f

    const v4, 0x7f0f0548

    new-instance v5, Lchat/ola/vn/signup/b$3;

    invoke-direct {v5, p0}, Lchat/ola/vn/signup/b$3;-><init>(Lchat/ola/vn/signup/b;)V

    invoke-static/range {v0 .. v5}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;IIIILandroid/content/DialogInterface$OnClickListener;)Landroid/app/Dialog;

    return-void

    :cond_1
    invoke-virtual {p0}, Lchat/ola/vn/signup/b;->v()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_2
    return-void

    nop

    :sswitch_data_0
    .sparse-switch
        0x7f090066 -> :sswitch_2
        0x7f0901cf -> :sswitch_1
        0x7f0901d0 -> :sswitch_1
        0x7f090373 -> :sswitch_0
    .end sparse-switch
.end method

.method public onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 0

    const p2, 0x7f0b0196

    const/4 p3, 0x0

    invoke-virtual {p1, p2, p3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p1

    invoke-direct {p0, p1}, Lchat/ola/vn/signup/b;->a(Landroid/view/View;)V

    invoke-virtual {p0}, Lchat/ola/vn/signup/b;->j()Lchat/ola/vn/signup/OlaSignUpActivity;

    move-result-object p2

    const p3, 0x7f010042

    invoke-static {p2, p3}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object p2

    iput-object p2, p0, Lchat/ola/vn/signup/b;->f:Landroid/view/animation/Animation;

    return-object p1
.end method
