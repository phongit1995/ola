.class final Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$PhoneCountryCode;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "PhoneCountryCode"
.end annotation


# instance fields
.field final countryCode:Ljava/lang/String;

.field final countryName:Ljava/lang/String;

.field final countrySymbol:Ljava/lang/String;

.field final isoCode:Ljava/lang/String;

.field final itemId:J


# direct methods
.method constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$PhoneCountryCode;->countryCode:Ljava/lang/String;

    iput-object p2, p0, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$PhoneCountryCode;->isoCode:Ljava/lang/String;

    iput-object p3, p0, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$PhoneCountryCode;->countryName:Ljava/lang/String;

    const-string p3, "[\\D]"

    const-string v0, ""

    invoke-virtual {p1, p3, v0}, Ljava/lang/String;->replaceAll(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result p3

    const/4 v0, 0x0

    :goto_0
    if-ge v0, p3, :cond_0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2, v0}, Ljava/lang/String;->charAt(I)C

    move-result p1

    invoke-static {p1}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_0
    invoke-static {p1}, Ljava/lang/Long;->valueOf(Ljava/lang/String;)Ljava/lang/Long;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Long;->longValue()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$PhoneCountryCode;->itemId:J

    invoke-static {}, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$PhoneCountryCode;->areFlagsSupported()Z

    move-result p1

    if-eqz p1, :cond_2

    invoke-static {p2}, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$PhoneCountryCode;->isoCodeToEmojiFlag(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result p3

    if-eqz p3, :cond_1

    move-object p1, p2

    :cond_1
    iput-object p1, p0, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$PhoneCountryCode;->countrySymbol:Ljava/lang/String;

    return-void

    :cond_2
    iput-object p2, p0, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$PhoneCountryCode;->countrySymbol:Ljava/lang/String;

    return-void
.end method

.method private static areFlagsSupported()Z
    .locals 2

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x17

    if-lt v0, v1, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method private static canShowFlagEmoji(Ljava/lang/String;)Z
    .locals 1
    .annotation build Landroid/annotation/TargetApi;
        value = 0x17
    .end annotation

    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0}, Landroid/graphics/Paint;-><init>()V

    invoke-virtual {v0, p0}, Landroid/graphics/Paint;->hasGlyph(Ljava/lang/String;)Z

    move-result p0

    return p0
.end method

.method private static isoCodeToEmojiFlag(Ljava/lang/String;)Ljava/lang/String;
    .locals 3

    const/4 v0, 0x0

    invoke-static {p0, v0}, Ljava/lang/Character;->codePointAt(Ljava/lang/CharSequence;I)I

    move-result v0

    add-int/lit8 v0, v0, -0x41

    const v1, 0x1f1e6

    add-int/2addr v0, v1

    const/4 v2, 0x1

    invoke-static {p0, v2}, Ljava/lang/Character;->codePointAt(Ljava/lang/CharSequence;I)I

    move-result p0

    add-int/lit8 p0, p0, -0x41

    add-int/2addr p0, v1

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    new-instance v2, Ljava/lang/String;

    invoke-static {v0}, Ljava/lang/Character;->toChars(I)[C

    move-result-object v0

    invoke-direct {v2, v0}, Ljava/lang/String;-><init>([C)V

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    new-instance v0, Ljava/lang/String;

    invoke-static {p0}, Ljava/lang/Character;->toChars(I)[C

    move-result-object p0

    invoke-direct {v0, p0}, Ljava/lang/String;-><init>([C)V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$PhoneCountryCode;->canShowFlagEmoji(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-object p0

    :cond_0
    const-string p0, ""

    return-object p0
.end method


# virtual methods
.method getCountryCode()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$PhoneCountryCode;->countryCode:Ljava/lang/String;

    return-object v0
.end method

.method getCountryName()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$PhoneCountryCode;->countryName:Ljava/lang/String;

    return-object v0
.end method

.method getCountrySymbol()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$PhoneCountryCode;->countrySymbol:Ljava/lang/String;

    return-object v0
.end method
