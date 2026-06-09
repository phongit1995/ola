.class final Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter;
.super Landroid/widget/BaseAdapter;

# interfaces
.implements Landroid/widget/SpinnerAdapter;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$ValueData;,
        Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$PhoneCountryCode;,
        Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$CountryCodeSource;
    }
.end annotation


# instance fields
.field private final context:Landroid/content/Context;

.field private final phoneCountryCodes:[Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$PhoneCountryCode;

.field private final uiManager:Lcom/facebook/accountkit/ui/UIManager;


# direct methods
.method public constructor <init>(Landroid/content/Context;Lcom/facebook/accountkit/ui/UIManager;[Ljava/lang/String;[Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0}, Landroid/widget/BaseAdapter;-><init>()V

    iput-object p1, p0, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter;->context:Landroid/content/Context;

    iput-object p2, p0, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter;->uiManager:Lcom/facebook/accountkit/ui/UIManager;

    invoke-static {p1, p3, p4}, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter;->getAllPhoneCountryCodes(Landroid/content/Context;[Ljava/lang/String;[Ljava/lang/String;)[Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$PhoneCountryCode;

    move-result-object p1

    iput-object p1, p0, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter;->phoneCountryCodes:[Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$PhoneCountryCode;

    return-void
.end method

.method private static getAllPhoneCountryCodes(Landroid/content/Context;[Ljava/lang/String;[Ljava/lang/String;)[Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$PhoneCountryCode;
    .locals 9

    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p0

    sget v0, Lcom/facebook/accountkit/R$array;->com_accountkit_phone_country_codes:I

    invoke-virtual {p0, v0}, Landroid/content/res/Resources;->getStringArray(I)[Ljava/lang/String;

    move-result-object p0

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    if-eqz p2, :cond_0

    new-instance v1, Ljava/util/HashSet;

    invoke-static {p2}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object p2

    invoke-direct {v1, p2}, Ljava/util/HashSet;-><init>(Ljava/util/Collection;)V

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    if-eqz p1, :cond_1

    array-length p2, p1

    if-lez p2, :cond_1

    new-instance p2, Ljava/util/HashSet;

    invoke-static {p1}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object p1

    invoke-direct {p2, p1}, Ljava/util/HashSet;-><init>(Ljava/util/Collection;)V

    goto :goto_1

    :cond_1
    new-instance p2, Ljava/util/HashSet;

    invoke-direct {p2}, Ljava/util/HashSet;-><init>()V

    :goto_1
    array-length p1, p0

    const/4 v2, 0x0

    const/4 v3, 0x0

    :goto_2
    if-ge v3, p1, :cond_4

    aget-object v4, p0, v3

    const-string v5, ":"

    const/4 v6, 0x3

    invoke-virtual {v4, v5, v6}, Ljava/lang/String;->split(Ljava/lang/String;I)[Ljava/lang/String;

    move-result-object v4

    const/4 v5, 0x1

    aget-object v6, v4, v5

    invoke-interface {p2, v6}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v6

    if-nez v6, :cond_3

    if-eqz v1, :cond_2

    aget-object v6, v4, v5

    invoke-interface {v1, v6}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_3

    :cond_2
    new-instance v6, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$PhoneCountryCode;

    aget-object v7, v4, v2

    aget-object v5, v4, v5

    const/4 v8, 0x2

    aget-object v4, v4, v8

    invoke-direct {v6, v7, v5, v4}, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$PhoneCountryCode;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v0, v6}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    :cond_3
    add-int/lit8 v3, v3, 0x1

    goto :goto_2

    :cond_4
    invoke-static {}, Landroid/content/res/Resources;->getSystem()Landroid/content/res/Resources;

    move-result-object p0

    invoke-virtual {p0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object p0

    iget-object p0, p0, Landroid/content/res/Configuration;->locale:Ljava/util/Locale;

    invoke-static {p0}, Ljava/text/Collator;->getInstance(Ljava/util/Locale;)Ljava/text/Collator;

    move-result-object p0

    invoke-virtual {p0, v2}, Ljava/text/Collator;->setStrength(I)V

    new-instance p1, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$1;

    invoke-direct {p1, p0}, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$1;-><init>(Ljava/text/Collator;)V

    invoke-static {v0, p1}, Ljava/util/Collections;->sort(Ljava/util/List;Ljava/util/Comparator;)V

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result p0

    new-array p0, p0, [Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$PhoneCountryCode;

    invoke-virtual {v0, p0}, Ljava/util/ArrayList;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    return-object p0
.end method

.method private getCountryLabel(Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$PhoneCountryCode;)Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$PhoneCountryCode;->getCountryName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, " (+"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$PhoneCountryCode;->getCountryCode()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, ")"

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method


# virtual methods
.method public getCount()I
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter;->phoneCountryCodes:[Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$PhoneCountryCode;

    array-length v0, v0

    return v0
.end method

.method public getDropDownView(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;
    .locals 2

    if-nez p2, :cond_0

    iget-object p2, p0, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter;->context:Landroid/content/Context;

    sget p3, Lcom/facebook/accountkit/R$layout;->com_accountkit_phone_country_code_item_layout:I

    const/4 v0, 0x0

    invoke-static {p2, p3, v0}, Landroid/view/View;->inflate(Landroid/content/Context;ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p2

    new-instance p3, Landroid/widget/AbsListView$LayoutParams;

    const/4 v0, -0x1

    invoke-direct {p3, v0, v0}, Landroid/widget/AbsListView$LayoutParams;-><init>(II)V

    invoke-virtual {p2, p3}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    :cond_0
    iget-object p3, p0, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter;->phoneCountryCodes:[Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$PhoneCountryCode;

    aget-object p1, p3, p1

    sget p3, Lcom/facebook/accountkit/R$id;->label:I

    invoke-virtual {p2, p3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p3

    check-cast p3, Landroid/widget/TextView;

    sget v0, Lcom/facebook/accountkit/R$id;->flag:I

    invoke-virtual {p2, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    invoke-direct {p0, p1}, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter;->getCountryLabel(Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$PhoneCountryCode;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p3, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$PhoneCountryCode;->getCountrySymbol()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-object p2
.end method

.method public getIndexOfCountryCode(Ljava/lang/String;)I
    .locals 4

    invoke-static {p1}, Lcom/facebook/accountkit/internal/Utility;->isNullOrEmpty(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, -0x1

    if-eqz v0, :cond_0

    return v1

    :cond_0
    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter;->phoneCountryCodes:[Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$PhoneCountryCode;

    array-length v0, v0

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v0, :cond_2

    iget-object v3, p0, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter;->phoneCountryCodes:[Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$PhoneCountryCode;

    aget-object v3, v3, v2

    iget-object v3, v3, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$PhoneCountryCode;->isoCode:Ljava/lang/String;

    invoke-virtual {p1, v3}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_1

    return v2

    :cond_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_2
    return v1
.end method

.method public getInitialValue(Lcom/facebook/accountkit/PhoneNumber;Ljava/lang/String;)Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$ValueData;
    .locals 7
    .param p1    # Lcom/facebook/accountkit/PhoneNumber;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param
    .param p2    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    const/4 v0, -0x1

    const/4 v1, 0x0

    const/4 v2, 0x0

    if-eqz p1, :cond_2

    sget-object v3, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$CountryCodeSource;->APP_SUPPLIED_PHONE_NUMBER:Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$CountryCodeSource;

    invoke-virtual {v3}, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$CountryCodeSource;->name()Ljava/lang/String;

    move-result-object v3

    iget-object v4, p0, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter;->phoneCountryCodes:[Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$PhoneCountryCode;

    array-length v4, v4

    invoke-virtual {p1}, Lcom/facebook/accountkit/PhoneNumber;->getCountryCode()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {p1}, Lcom/facebook/accountkit/PhoneNumber;->getCountryCodeIso()Ljava/lang/String;

    move-result-object p1

    if-eqz p1, :cond_0

    invoke-virtual {p0, p1}, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter;->getIndexOfCountryCode(Ljava/lang/String;)I

    move-result p1

    goto :goto_1

    :cond_0
    const/4 p1, 0x0

    :goto_0
    if-ge p1, v4, :cond_3

    iget-object v6, p0, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter;->phoneCountryCodes:[Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$PhoneCountryCode;

    aget-object v6, v6, p1

    iget-object v6, v6, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$PhoneCountryCode;->countryCode:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_1

    goto :goto_1

    :cond_1
    add-int/lit8 p1, p1, 0x1

    goto :goto_0

    :cond_2
    move-object v3, v2

    move-object v5, v3

    :cond_3
    const/4 p1, -0x1

    :goto_1
    move-object v4, v3

    move v3, p1

    const/4 p1, 0x0

    :goto_2
    const/4 v6, 0x3

    if-gt p1, v6, :cond_5

    if-ne v3, v0, :cond_5

    packed-switch p1, :pswitch_data_0

    iget-object v4, p0, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter;->phoneCountryCodes:[Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$PhoneCountryCode;

    aget-object v4, v4, v3

    iget-object v4, v4, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$PhoneCountryCode;->isoCode:Ljava/lang/String;

    iget-object v5, p0, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter;->phoneCountryCodes:[Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$PhoneCountryCode;

    aget-object v5, v5, v3

    :goto_3
    iget-object v5, v5, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$PhoneCountryCode;->countryCode:Ljava/lang/String;

    goto :goto_4

    :pswitch_0
    sget-object v4, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$CountryCodeSource;->FIRST_VALUE:Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$CountryCodeSource;

    invoke-virtual {v4}, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$CountryCodeSource;->name()Ljava/lang/String;

    move-result-object v4

    iget-object v5, p0, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter;->phoneCountryCodes:[Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$PhoneCountryCode;

    aget-object v5, v5, v1

    goto :goto_3

    :pswitch_1
    sget-object v4, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$CountryCodeSource;->DEFAULT_VALUE:Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$CountryCodeSource;

    invoke-virtual {v4}, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$CountryCodeSource;->name()Ljava/lang/String;

    move-result-object v4

    const-string v5, "US"

    goto :goto_4

    :pswitch_2
    sget-object v4, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$CountryCodeSource;->TELEPHONY_SERVICE:Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$CountryCodeSource;

    invoke-virtual {v4}, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$CountryCodeSource;->name()Ljava/lang/String;

    move-result-object v4

    iget-object v5, p0, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter;->context:Landroid/content/Context;

    invoke-static {v5}, Lcom/facebook/accountkit/internal/Utility;->getCurrentCountry(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v5

    goto :goto_4

    :pswitch_3
    sget-object v4, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$CountryCodeSource;->APP_SUPPLIED_DEFAULT_VALUE:Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$CountryCodeSource;

    invoke-virtual {v4}, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$CountryCodeSource;->name()Ljava/lang/String;

    move-result-object v4

    move-object v5, p2

    :goto_4
    if-gt p1, v6, :cond_4

    invoke-virtual {p0, v5}, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter;->getIndexOfCountryCode(Ljava/lang/String;)I

    move-result v3

    :cond_4
    add-int/lit8 p1, p1, 0x1

    goto :goto_2

    :cond_5
    new-instance p1, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$ValueData;

    invoke-direct {p1, v5, v4, v3, v2}, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$ValueData;-><init>(Ljava/lang/String;Ljava/lang/String;ILcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$1;)V

    return-object p1

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public getItem(I)Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$ValueData;
    .locals 4

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter;->phoneCountryCodes:[Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$PhoneCountryCode;

    aget-object v0, v0, p1

    new-instance v1, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$ValueData;

    iget-object v2, v0, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$PhoneCountryCode;->countryCode:Ljava/lang/String;

    iget-object v0, v0, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$PhoneCountryCode;->isoCode:Ljava/lang/String;

    const/4 v3, 0x0

    invoke-direct {v1, v2, v0, p1, v3}, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$ValueData;-><init>(Ljava/lang/String;Ljava/lang/String;ILcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$1;)V

    return-object v1
.end method

.method public bridge synthetic getItem(I)Ljava/lang/Object;
    .locals 0

    invoke-virtual {p0, p1}, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter;->getItem(I)Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$ValueData;

    move-result-object p1

    return-object p1
.end method

.method public getItemId(I)J
    .locals 2

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter;->phoneCountryCodes:[Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$PhoneCountryCode;

    aget-object p1, v0, p1

    iget-wide v0, p1, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$PhoneCountryCode;->itemId:J

    return-wide v0
.end method

.method public getView(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;
    .locals 2

    if-nez p2, :cond_0

    iget-object p2, p0, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter;->context:Landroid/content/Context;

    sget v0, Lcom/facebook/accountkit/R$layout;->com_accountkit_phone_country_code_layout:I

    const/4 v1, 0x0

    invoke-static {p2, v0, v1}, Landroid/view/View;->inflate(Landroid/content/Context;ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p2

    new-instance v0, Landroid/view/ViewGroup$LayoutParams;

    invoke-virtual {p3}, Landroid/view/ViewGroup;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object p3

    invoke-direct {v0, p3}, Landroid/view/ViewGroup$LayoutParams;-><init>(Landroid/view/ViewGroup$LayoutParams;)V

    invoke-virtual {p2, v0}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    :cond_0
    iget-object p3, p0, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter;->phoneCountryCodes:[Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$PhoneCountryCode;

    aget-object p1, p3, p1

    sget p3, Lcom/facebook/accountkit/R$id;->country_code:I

    invoke-virtual {p2, p3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p3

    check-cast p3, Landroid/widget/TextView;

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$PhoneCountryCode;->getCountrySymbol()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p3, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter;->uiManager:Lcom/facebook/accountkit/ui/UIManager;

    invoke-static {p1}, Lcom/facebook/accountkit/ui/ViewUtility;->useLegacy(Lcom/facebook/accountkit/ui/UIManager;)Z

    move-result p1

    if-nez p1, :cond_1

    iget-object p1, p0, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter;->uiManager:Lcom/facebook/accountkit/ui/UIManager;

    check-cast p1, Lcom/facebook/accountkit/ui/SkinManager;

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/SkinManager;->getTextColor()I

    move-result p1

    invoke-virtual {p3, p1}, Landroid/widget/TextView;->setTextColor(I)V

    :cond_1
    return-object p2
.end method
