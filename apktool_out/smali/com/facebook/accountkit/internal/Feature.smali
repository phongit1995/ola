.class public final enum Lcom/facebook/accountkit/internal/Feature;
.super Ljava/lang/Enum;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/facebook/accountkit/internal/Feature;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/facebook/accountkit/internal/Feature;

.field public static final enum CALLBACK_BUTTON_ALTERNATE_TEXT:Lcom/facebook/accountkit/internal/Feature;

.field public static final enum EMAIL_ENABLED:Lcom/facebook/accountkit/internal/Feature;

.field public static final enum PHONE_NUMBER_ENABLED:Lcom/facebook/accountkit/internal/Feature;


# instance fields
.field private defaultValue:I

.field private prefKey:I


# direct methods
.method static constructor <clinit>()V
    .locals 5

    new-instance v0, Lcom/facebook/accountkit/internal/Feature;

    const-string v1, "EMAIL_ENABLED"

    const/4 v2, 0x0

    const/4 v3, 0x1

    invoke-direct {v0, v1, v2, v2, v3}, Lcom/facebook/accountkit/internal/Feature;-><init>(Ljava/lang/String;III)V

    sput-object v0, Lcom/facebook/accountkit/internal/Feature;->EMAIL_ENABLED:Lcom/facebook/accountkit/internal/Feature;

    new-instance v0, Lcom/facebook/accountkit/internal/Feature;

    const-string v1, "PHONE_NUMBER_ENABLED"

    invoke-direct {v0, v1, v3, v3, v3}, Lcom/facebook/accountkit/internal/Feature;-><init>(Ljava/lang/String;III)V

    sput-object v0, Lcom/facebook/accountkit/internal/Feature;->PHONE_NUMBER_ENABLED:Lcom/facebook/accountkit/internal/Feature;

    new-instance v0, Lcom/facebook/accountkit/internal/Feature;

    const-string v1, "CALLBACK_BUTTON_ALTERNATE_TEXT"

    const/4 v4, 0x2

    invoke-direct {v0, v1, v4, v4, v3}, Lcom/facebook/accountkit/internal/Feature;-><init>(Ljava/lang/String;III)V

    sput-object v0, Lcom/facebook/accountkit/internal/Feature;->CALLBACK_BUTTON_ALTERNATE_TEXT:Lcom/facebook/accountkit/internal/Feature;

    const/4 v0, 0x3

    new-array v0, v0, [Lcom/facebook/accountkit/internal/Feature;

    sget-object v1, Lcom/facebook/accountkit/internal/Feature;->EMAIL_ENABLED:Lcom/facebook/accountkit/internal/Feature;

    aput-object v1, v0, v2

    sget-object v1, Lcom/facebook/accountkit/internal/Feature;->PHONE_NUMBER_ENABLED:Lcom/facebook/accountkit/internal/Feature;

    aput-object v1, v0, v3

    sget-object v1, Lcom/facebook/accountkit/internal/Feature;->CALLBACK_BUTTON_ALTERNATE_TEXT:Lcom/facebook/accountkit/internal/Feature;

    aput-object v1, v0, v4

    sput-object v0, Lcom/facebook/accountkit/internal/Feature;->$VALUES:[Lcom/facebook/accountkit/internal/Feature;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;III)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(II)V"
        }
    .end annotation

    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    iput p3, p0, Lcom/facebook/accountkit/internal/Feature;->prefKey:I

    iput p4, p0, Lcom/facebook/accountkit/internal/Feature;->defaultValue:I

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/facebook/accountkit/internal/Feature;
    .locals 1

    const-class v0, Lcom/facebook/accountkit/internal/Feature;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lcom/facebook/accountkit/internal/Feature;

    return-object p0
.end method

.method public static values()[Lcom/facebook/accountkit/internal/Feature;
    .locals 1

    sget-object v0, Lcom/facebook/accountkit/internal/Feature;->$VALUES:[Lcom/facebook/accountkit/internal/Feature;

    invoke-virtual {v0}, [Lcom/facebook/accountkit/internal/Feature;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/facebook/accountkit/internal/Feature;

    return-object v0
.end method


# virtual methods
.method getDefaultValue()I
    .locals 1

    iget v0, p0, Lcom/facebook/accountkit/internal/Feature;->defaultValue:I

    return v0
.end method

.method getPrefKey()I
    .locals 1

    iget v0, p0, Lcom/facebook/accountkit/internal/Feature;->prefKey:I

    return v0
.end method
