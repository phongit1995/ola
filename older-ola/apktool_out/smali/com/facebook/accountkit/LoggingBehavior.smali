.class public final enum Lcom/facebook/accountkit/LoggingBehavior;
.super Ljava/lang/Enum;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/facebook/accountkit/LoggingBehavior;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/facebook/accountkit/LoggingBehavior;

.field public static final enum APP_EVENTS:Lcom/facebook/accountkit/LoggingBehavior;

.field public static final enum CACHE:Lcom/facebook/accountkit/LoggingBehavior;

.field public static final enum DEVELOPER_ERRORS:Lcom/facebook/accountkit/LoggingBehavior;

.field public static final enum INCLUDE_ACCESS_TOKENS:Lcom/facebook/accountkit/LoggingBehavior;

.field public static final enum INCLUDE_RAW_RESPONSES:Lcom/facebook/accountkit/LoggingBehavior;

.field public static final enum REQUESTS:Lcom/facebook/accountkit/LoggingBehavior;


# direct methods
.method static constructor <clinit>()V
    .locals 8

    new-instance v0, Lcom/facebook/accountkit/LoggingBehavior;

    const-string v1, "REQUESTS"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lcom/facebook/accountkit/LoggingBehavior;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/LoggingBehavior;->REQUESTS:Lcom/facebook/accountkit/LoggingBehavior;

    new-instance v0, Lcom/facebook/accountkit/LoggingBehavior;

    const-string v1, "INCLUDE_ACCESS_TOKENS"

    const/4 v3, 0x1

    invoke-direct {v0, v1, v3}, Lcom/facebook/accountkit/LoggingBehavior;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/LoggingBehavior;->INCLUDE_ACCESS_TOKENS:Lcom/facebook/accountkit/LoggingBehavior;

    new-instance v0, Lcom/facebook/accountkit/LoggingBehavior;

    const-string v1, "INCLUDE_RAW_RESPONSES"

    const/4 v4, 0x2

    invoke-direct {v0, v1, v4}, Lcom/facebook/accountkit/LoggingBehavior;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/LoggingBehavior;->INCLUDE_RAW_RESPONSES:Lcom/facebook/accountkit/LoggingBehavior;

    new-instance v0, Lcom/facebook/accountkit/LoggingBehavior;

    const-string v1, "APP_EVENTS"

    const/4 v5, 0x3

    invoke-direct {v0, v1, v5}, Lcom/facebook/accountkit/LoggingBehavior;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/LoggingBehavior;->APP_EVENTS:Lcom/facebook/accountkit/LoggingBehavior;

    new-instance v0, Lcom/facebook/accountkit/LoggingBehavior;

    const-string v1, "CACHE"

    const/4 v6, 0x4

    invoke-direct {v0, v1, v6}, Lcom/facebook/accountkit/LoggingBehavior;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/LoggingBehavior;->CACHE:Lcom/facebook/accountkit/LoggingBehavior;

    new-instance v0, Lcom/facebook/accountkit/LoggingBehavior;

    const-string v1, "DEVELOPER_ERRORS"

    const/4 v7, 0x5

    invoke-direct {v0, v1, v7}, Lcom/facebook/accountkit/LoggingBehavior;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/LoggingBehavior;->DEVELOPER_ERRORS:Lcom/facebook/accountkit/LoggingBehavior;

    const/4 v0, 0x6

    new-array v0, v0, [Lcom/facebook/accountkit/LoggingBehavior;

    sget-object v1, Lcom/facebook/accountkit/LoggingBehavior;->REQUESTS:Lcom/facebook/accountkit/LoggingBehavior;

    aput-object v1, v0, v2

    sget-object v1, Lcom/facebook/accountkit/LoggingBehavior;->INCLUDE_ACCESS_TOKENS:Lcom/facebook/accountkit/LoggingBehavior;

    aput-object v1, v0, v3

    sget-object v1, Lcom/facebook/accountkit/LoggingBehavior;->INCLUDE_RAW_RESPONSES:Lcom/facebook/accountkit/LoggingBehavior;

    aput-object v1, v0, v4

    sget-object v1, Lcom/facebook/accountkit/LoggingBehavior;->APP_EVENTS:Lcom/facebook/accountkit/LoggingBehavior;

    aput-object v1, v0, v5

    sget-object v1, Lcom/facebook/accountkit/LoggingBehavior;->CACHE:Lcom/facebook/accountkit/LoggingBehavior;

    aput-object v1, v0, v6

    sget-object v1, Lcom/facebook/accountkit/LoggingBehavior;->DEVELOPER_ERRORS:Lcom/facebook/accountkit/LoggingBehavior;

    aput-object v1, v0, v7

    sput-object v0, Lcom/facebook/accountkit/LoggingBehavior;->$VALUES:[Lcom/facebook/accountkit/LoggingBehavior;

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

.method public static valueOf(Ljava/lang/String;)Lcom/facebook/accountkit/LoggingBehavior;
    .locals 1

    const-class v0, Lcom/facebook/accountkit/LoggingBehavior;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lcom/facebook/accountkit/LoggingBehavior;

    return-object p0
.end method

.method public static values()[Lcom/facebook/accountkit/LoggingBehavior;
    .locals 1

    sget-object v0, Lcom/facebook/accountkit/LoggingBehavior;->$VALUES:[Lcom/facebook/accountkit/LoggingBehavior;

    invoke-virtual {v0}, [Lcom/facebook/accountkit/LoggingBehavior;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/facebook/accountkit/LoggingBehavior;

    return-object v0
.end method
