.class final enum Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$CountryCodeSource;
.super Ljava/lang/Enum;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x401a
    name = "CountryCodeSource"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$CountryCodeSource;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$CountryCodeSource;

.field public static final enum APP_SUPPLIED_DEFAULT_VALUE:Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$CountryCodeSource;

.field public static final enum APP_SUPPLIED_PHONE_NUMBER:Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$CountryCodeSource;

.field public static final enum DEFAULT_VALUE:Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$CountryCodeSource;

.field public static final enum FIRST_VALUE:Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$CountryCodeSource;

.field public static final enum TELEPHONY_SERVICE:Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$CountryCodeSource;


# direct methods
.method static constructor <clinit>()V
    .locals 7

    new-instance v0, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$CountryCodeSource;

    const-string v1, "APP_SUPPLIED_DEFAULT_VALUE"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$CountryCodeSource;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$CountryCodeSource;->APP_SUPPLIED_DEFAULT_VALUE:Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$CountryCodeSource;

    new-instance v0, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$CountryCodeSource;

    const-string v1, "APP_SUPPLIED_PHONE_NUMBER"

    const/4 v3, 0x1

    invoke-direct {v0, v1, v3}, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$CountryCodeSource;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$CountryCodeSource;->APP_SUPPLIED_PHONE_NUMBER:Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$CountryCodeSource;

    new-instance v0, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$CountryCodeSource;

    const-string v1, "DEFAULT_VALUE"

    const/4 v4, 0x2

    invoke-direct {v0, v1, v4}, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$CountryCodeSource;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$CountryCodeSource;->DEFAULT_VALUE:Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$CountryCodeSource;

    new-instance v0, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$CountryCodeSource;

    const-string v1, "FIRST_VALUE"

    const/4 v5, 0x3

    invoke-direct {v0, v1, v5}, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$CountryCodeSource;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$CountryCodeSource;->FIRST_VALUE:Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$CountryCodeSource;

    new-instance v0, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$CountryCodeSource;

    const-string v1, "TELEPHONY_SERVICE"

    const/4 v6, 0x4

    invoke-direct {v0, v1, v6}, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$CountryCodeSource;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$CountryCodeSource;->TELEPHONY_SERVICE:Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$CountryCodeSource;

    const/4 v0, 0x5

    new-array v0, v0, [Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$CountryCodeSource;

    sget-object v1, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$CountryCodeSource;->APP_SUPPLIED_DEFAULT_VALUE:Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$CountryCodeSource;

    aput-object v1, v0, v2

    sget-object v1, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$CountryCodeSource;->APP_SUPPLIED_PHONE_NUMBER:Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$CountryCodeSource;

    aput-object v1, v0, v3

    sget-object v1, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$CountryCodeSource;->DEFAULT_VALUE:Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$CountryCodeSource;

    aput-object v1, v0, v4

    sget-object v1, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$CountryCodeSource;->FIRST_VALUE:Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$CountryCodeSource;

    aput-object v1, v0, v5

    sget-object v1, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$CountryCodeSource;->TELEPHONY_SERVICE:Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$CountryCodeSource;

    aput-object v1, v0, v6

    sput-object v0, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$CountryCodeSource;->$VALUES:[Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$CountryCodeSource;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$CountryCodeSource;
    .locals 1

    const-class v0, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$CountryCodeSource;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$CountryCodeSource;

    return-object p0
.end method

.method public static values()[Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$CountryCodeSource;
    .locals 1

    sget-object v0, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$CountryCodeSource;->$VALUES:[Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$CountryCodeSource;

    invoke-virtual {v0}, [Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$CountryCodeSource;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$CountryCodeSource;

    return-object v0
.end method
