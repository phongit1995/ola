.class public Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;
.super Lchat/ola/vn/c;

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Ljava/util/Comparator;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lchat/ola/vn/c;",
        "Landroid/view/View$OnClickListener;",
        "Ljava/util/Comparator<",
        "Lchat/ola/vn/countrypicker/a;",
        ">;"
    }
.end annotation


# static fields
.field public static e:Lchat/ola/vn/countrypicker/c;


# instance fields
.field private f:Landroid/widget/EditText;

.field private g:Landroid/widget/ListView;

.field private h:Lchat/ola/vn/countrypicker/b;

.field private i:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/countrypicker/a;",
            ">;"
        }
    .end annotation
.end field

.field private j:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/countrypicker/a;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/c;-><init>()V

    return-void
.end method

.method private B()Ljava/util/List;
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lchat/ola/vn/countrypicker/a;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;->i:Ljava/util/List;

    if-nez v0, :cond_1

    :try_start_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;->i:Ljava/util/List;

    invoke-static {p0}, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;->c(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Lorg/json/JSONArray;

    invoke-direct {v1, v0}, Lorg/json/JSONArray;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1}, Lorg/json/JSONArray;->length()I

    move-result v0

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v0, :cond_0

    invoke-virtual {v1, v2}, Lorg/json/JSONArray;->getJSONObject(I)Lorg/json/JSONObject;

    move-result-object v3

    const-string v4, "countryCode"

    invoke-virtual {v3, v4}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    sget-object v5, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v4, v5}, Ljava/lang/String;->toUpperCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v4

    new-instance v5, Lchat/ola/vn/countrypicker/a;

    invoke-direct {v5}, Lchat/ola/vn/countrypicker/a;-><init>()V

    invoke-virtual {v5, v4}, Lchat/ola/vn/countrypicker/a;->a(Ljava/lang/String;)V

    const-string v4, "countryName"

    invoke-virtual {v3, v4}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v5, v4}, Lchat/ola/vn/countrypicker/a;->b(Ljava/lang/String;)V

    const-string v4, "phoneCode"

    invoke-virtual {v3, v4}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v5, v3}, Lchat/ola/vn/countrypicker/a;->c(Ljava/lang/String;)V

    iget-object v3, p0, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;->i:Ljava/util/List;

    invoke-interface {v3, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;->i:Ljava/util/List;

    invoke-static {v0, p0}, Ljava/util/Collections;->sort(Ljava/util/List;Ljava/util/Comparator;)V

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;->j:Ljava/util/List;

    iget-object v0, p0, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;->j:Ljava/util/List;

    iget-object v1, p0, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;->i:Ljava/util/List;

    invoke-interface {v0, v1}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    iget-object v0, p0, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;->i:Ljava/util/List;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    :cond_1
    const/4 v0, 0x0

    return-object v0
.end method

.method static synthetic a(Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;)Landroid/widget/EditText;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;->f:Landroid/widget/EditText;

    return-object p0
.end method

.method public static a(Landroid/content/Context;)Ljava/util/Map;
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            ")",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lchat/ola/vn/countrypicker/a;",
            ">;"
        }
    .end annotation

    :try_start_0
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    invoke-static {p0}, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;->c(Landroid/content/Context;)Ljava/lang/String;

    move-result-object p0

    new-instance v1, Lorg/json/JSONArray;

    invoke-direct {v1, p0}, Lorg/json/JSONArray;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1}, Lorg/json/JSONArray;->length()I

    move-result p0

    const/4 v2, 0x0

    :goto_0
    if-ge v2, p0, :cond_0

    invoke-virtual {v1, v2}, Lorg/json/JSONArray;->getJSONObject(I)Lorg/json/JSONObject;

    move-result-object v3

    const-string v4, "countryCode"

    invoke-virtual {v3, v4}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    sget-object v5, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v4, v5}, Ljava/lang/String;->toUpperCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v4

    new-instance v5, Lchat/ola/vn/countrypicker/a;

    invoke-direct {v5}, Lchat/ola/vn/countrypicker/a;-><init>()V

    invoke-virtual {v5, v4}, Lchat/ola/vn/countrypicker/a;->a(Ljava/lang/String;)V

    const-string v4, "countryName"

    invoke-virtual {v3, v4}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v5, v4}, Lchat/ola/vn/countrypicker/a;->b(Ljava/lang/String;)V

    const-string v4, "phoneCode"

    invoke-virtual {v3, v4}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v5, v3}, Lchat/ola/vn/countrypicker/a;->c(Ljava/lang/String;)V

    invoke-virtual {v5}, Lchat/ola/vn/countrypicker/a;->a()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v0, v3, v5}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_0
    return-object v0

    :catch_0
    const/4 p0, 0x0

    return-object p0
.end method

.method static synthetic a(Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;->f(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic b(Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;)Ljava/util/List;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;->j:Ljava/util/List;

    return-object p0
.end method

.method public static b(Landroid/content/Context;)V
    .locals 2

    :try_start_0
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const/high16 v1, 0x50000000

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    invoke-virtual {p0, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    check-cast p0, Landroid/app/Activity;

    const v0, 0x7f010036

    const v1, 0x7f01003d

    invoke-virtual {p0, v0, v1}, Landroid/app/Activity;->overridePendingTransition(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private static c(Landroid/content/Context;)Ljava/lang/String;
    .locals 2

    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p0

    const v0, 0x7f0f0097

    invoke-virtual {p0, v0}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object p0

    const/4 v0, 0x0

    invoke-static {p0, v0}, Landroid/util/Base64;->decode(Ljava/lang/String;I)[B

    move-result-object p0

    new-instance v0, Ljava/lang/String;

    const-string v1, "UTF-8"

    invoke-direct {v0, p0, v1}, Ljava/lang/String;-><init>([BLjava/lang/String;)V

    return-object v0
.end method

.method private f(Ljava/lang/String;)V
    .locals 4
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "DefaultLocale"
        }
    .end annotation

    iget-object v0, p0, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;->j:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    iget-object v0, p0, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;->i:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_0
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/countrypicker/a;

    invoke-virtual {v1}, Lchat/ola/vn/countrypicker/a;->b()Ljava/lang/String;

    move-result-object v2

    sget-object v3, Ljava/util/Locale;->ENGLISH:Ljava/util/Locale;

    invoke-virtual {v2, v3}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p1}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_0

    iget-object v2, p0, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;->j:Ljava/util/List;

    invoke-interface {v2, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;->h:Lchat/ola/vn/countrypicker/b;

    invoke-virtual {p1}, Lchat/ola/vn/countrypicker/b;->notifyDataSetChanged()V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/countrypicker/a;Lchat/ola/vn/countrypicker/a;)I
    .locals 2

    invoke-virtual {p1}, Lchat/ola/vn/countrypicker/a;->c()Ljava/lang/String;

    move-result-object v0

    const-string v1, "84"

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p2}, Lchat/ola/vn/countrypicker/a;->c()Ljava/lang/String;

    move-result-object v0

    const-string v1, "84"

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    const/4 p1, -0x1

    return p1

    :cond_0
    invoke-virtual {p1}, Lchat/ola/vn/countrypicker/a;->c()Ljava/lang/String;

    move-result-object v0

    const-string v1, "84"

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    invoke-virtual {p2}, Lchat/ola/vn/countrypicker/a;->c()Ljava/lang/String;

    move-result-object v0

    const-string v1, "84"

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    const/4 p1, 0x1

    return p1

    :cond_1
    invoke-virtual {p1}, Lchat/ola/vn/countrypicker/a;->c()Ljava/lang/String;

    move-result-object v0

    const-string v1, "84"

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-virtual {p2}, Lchat/ola/vn/countrypicker/a;->c()Ljava/lang/String;

    move-result-object v0

    const-string v1, "84"

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    const/4 p1, 0x0

    return p1

    :cond_2
    invoke-virtual {p1}, Lchat/ola/vn/countrypicker/a;->b()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2}, Lchat/ola/vn/countrypicker/a;->b()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result p1

    return p1
.end method

.method protected a()V
    .locals 0

    return-void
.end method

.method protected b()Z
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public synthetic compare(Ljava/lang/Object;Ljava/lang/Object;)I
    .locals 0

    check-cast p1, Lchat/ola/vn/countrypicker/a;

    check-cast p2, Lchat/ola/vn/countrypicker/a;

    invoke-virtual {p0, p1, p2}, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;->a(Lchat/ola/vn/countrypicker/a;Lchat/ola/vn/countrypicker/a;)I

    move-result p1

    return p1
.end method

.method public finish()V
    .locals 2

    invoke-super {p0}, Lchat/ola/vn/c;->finish()V

    const v0, 0x7f01003c

    const v1, 0x7f010037

    :try_start_0
    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;->overridePendingTransition(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 2

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const v0, 0x7f09039c

    if-eq p1, v0, :cond_0

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;->finish()V

    :goto_0
    invoke-virtual {p0}, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;->getParent()Landroid/app/Activity;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;->f:Landroid/widget/EditText;

    const/4 v1, 0x0

    invoke-static {p1, v0, v1}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;Landroid/view/View;Z)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 1

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    const p1, 0x7f0b0082

    invoke-virtual {p0, p1}, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;->setContentView(I)V

    invoke-direct {p0}, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;->B()Ljava/util/List;

    const p1, 0x7f09039c

    invoke-virtual {p0, p1}, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f0903a3

    invoke-virtual {p0, p1}, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    const v0, 0x7f0f0605

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(I)V

    const p1, 0x7f090450

    invoke-virtual {p0, p1}, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/EditText;

    iput-object p1, p0, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;->f:Landroid/widget/EditText;

    iget-object p1, p0, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;->f:Landroid/widget/EditText;

    new-instance v0, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity$1;

    invoke-direct {v0, p0}, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity$1;-><init>(Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;)V

    invoke-virtual {p1, v0}, Landroid/widget/EditText;->setOnFocusChangeListener(Landroid/view/View$OnFocusChangeListener;)V

    const p1, 0x7f090453

    invoke-virtual {p0, p1}, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    new-instance v0, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity$2;

    invoke-direct {v0, p0}, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity$2;-><init>(Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;)V

    invoke-virtual {p1, v0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f0901d2

    invoke-virtual {p0, p1}, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/ListView;

    iput-object p1, p0, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;->g:Landroid/widget/ListView;

    new-instance p1, Lchat/ola/vn/countrypicker/b;

    iget-object v0, p0, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;->j:Ljava/util/List;

    invoke-direct {p1, p0, v0}, Lchat/ola/vn/countrypicker/b;-><init>(Landroid/content/Context;Ljava/util/List;)V

    iput-object p1, p0, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;->h:Lchat/ola/vn/countrypicker/b;

    iget-object p1, p0, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;->g:Landroid/widget/ListView;

    iget-object v0, p0, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;->h:Lchat/ola/vn/countrypicker/b;

    invoke-virtual {p1, v0}, Landroid/widget/ListView;->setAdapter(Landroid/widget/ListAdapter;)V

    iget-object p1, p0, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;->g:Landroid/widget/ListView;

    new-instance v0, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity$3;

    invoke-direct {v0, p0}, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity$3;-><init>(Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;)V

    invoke-virtual {p1, v0}, Landroid/widget/ListView;->setOnItemClickListener(Landroid/widget/AdapterView$OnItemClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;->f:Landroid/widget/EditText;

    new-instance v0, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity$4;

    invoke-direct {v0, p0}, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity$4;-><init>(Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;)V

    invoke-virtual {p1, v0}, Landroid/widget/EditText;->addTextChangedListener(Landroid/text/TextWatcher;)V

    return-void
.end method
