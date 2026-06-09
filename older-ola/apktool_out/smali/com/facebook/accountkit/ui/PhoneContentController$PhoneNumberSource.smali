.class final enum Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;
.super Ljava/lang/Enum;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/facebook/accountkit/ui/PhoneContentController;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4018
    name = "PhoneNumberSource"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;

.field public static final enum APP_SUPPLIED_AND_DEVICE_PHONE_NUMBER:Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;

.field public static final enum APP_SUPPLIED_PHONE_NUMBER:Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;

.field public static final enum DEVICE_PHONE_NUMBER:Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;

.field public static final enum DEVICE_PHONE_NUMBER_AND_APP_NUMBER_NOT_SUPPLIED:Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;

.field public static final enum DEVICE_PHONE_NUMBER_NOT_SUPPLIED:Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;

.field public static final enum UNKNOWN:Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;


# direct methods
.method static constructor <clinit>()V
    .locals 8

    new-instance v0, Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;

    const-string v1, "UNKNOWN"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;->UNKNOWN:Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;

    new-instance v0, Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;

    const-string v1, "APP_SUPPLIED_PHONE_NUMBER"

    const/4 v3, 0x1

    invoke-direct {v0, v1, v3}, Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;->APP_SUPPLIED_PHONE_NUMBER:Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;

    new-instance v0, Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;

    const-string v1, "APP_SUPPLIED_AND_DEVICE_PHONE_NUMBER"

    const/4 v4, 0x2

    invoke-direct {v0, v1, v4}, Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;->APP_SUPPLIED_AND_DEVICE_PHONE_NUMBER:Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;

    new-instance v0, Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;

    const-string v1, "DEVICE_PHONE_NUMBER"

    const/4 v5, 0x3

    invoke-direct {v0, v1, v5}, Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;->DEVICE_PHONE_NUMBER:Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;

    new-instance v0, Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;

    const-string v1, "DEVICE_PHONE_NUMBER_AND_APP_NUMBER_NOT_SUPPLIED"

    const/4 v6, 0x4

    invoke-direct {v0, v1, v6}, Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;->DEVICE_PHONE_NUMBER_AND_APP_NUMBER_NOT_SUPPLIED:Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;

    new-instance v0, Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;

    const-string v1, "DEVICE_PHONE_NUMBER_NOT_SUPPLIED"

    const/4 v7, 0x5

    invoke-direct {v0, v1, v7}, Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;->DEVICE_PHONE_NUMBER_NOT_SUPPLIED:Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;

    const/4 v0, 0x6

    new-array v0, v0, [Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;

    sget-object v1, Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;->UNKNOWN:Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;

    aput-object v1, v0, v2

    sget-object v1, Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;->APP_SUPPLIED_PHONE_NUMBER:Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;

    aput-object v1, v0, v3

    sget-object v1, Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;->APP_SUPPLIED_AND_DEVICE_PHONE_NUMBER:Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;

    aput-object v1, v0, v4

    sget-object v1, Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;->DEVICE_PHONE_NUMBER:Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;

    aput-object v1, v0, v5

    sget-object v1, Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;->DEVICE_PHONE_NUMBER_AND_APP_NUMBER_NOT_SUPPLIED:Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;

    aput-object v1, v0, v6

    sget-object v1, Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;->DEVICE_PHONE_NUMBER_NOT_SUPPLIED:Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;

    aput-object v1, v0, v7

    sput-object v0, Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;->$VALUES:[Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;

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

.method public static valueOf(Ljava/lang/String;)Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;
    .locals 1

    const-class v0, Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;

    return-object p0
.end method

.method public static values()[Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;
    .locals 1

    sget-object v0, Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;->$VALUES:[Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;

    invoke-virtual {v0}, [Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;

    return-object v0
.end method
