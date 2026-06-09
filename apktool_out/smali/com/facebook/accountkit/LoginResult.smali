.class public final enum Lcom/facebook/accountkit/LoginResult;
.super Ljava/lang/Enum;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/facebook/accountkit/LoginResult;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/facebook/accountkit/LoginResult;

.field public static final enum CANCELLED:Lcom/facebook/accountkit/LoginResult;

.field public static final enum SUCCESS:Lcom/facebook/accountkit/LoginResult;


# direct methods
.method static constructor <clinit>()V
    .locals 4

    new-instance v0, Lcom/facebook/accountkit/LoginResult;

    const-string v1, "SUCCESS"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lcom/facebook/accountkit/LoginResult;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/LoginResult;->SUCCESS:Lcom/facebook/accountkit/LoginResult;

    new-instance v0, Lcom/facebook/accountkit/LoginResult;

    const-string v1, "CANCELLED"

    const/4 v3, 0x1

    invoke-direct {v0, v1, v3}, Lcom/facebook/accountkit/LoginResult;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/LoginResult;->CANCELLED:Lcom/facebook/accountkit/LoginResult;

    const/4 v0, 0x2

    new-array v0, v0, [Lcom/facebook/accountkit/LoginResult;

    sget-object v1, Lcom/facebook/accountkit/LoginResult;->SUCCESS:Lcom/facebook/accountkit/LoginResult;

    aput-object v1, v0, v2

    sget-object v1, Lcom/facebook/accountkit/LoginResult;->CANCELLED:Lcom/facebook/accountkit/LoginResult;

    aput-object v1, v0, v3

    sput-object v0, Lcom/facebook/accountkit/LoginResult;->$VALUES:[Lcom/facebook/accountkit/LoginResult;

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

.method public static valueOf(Ljava/lang/String;)Lcom/facebook/accountkit/LoginResult;
    .locals 1

    const-class v0, Lcom/facebook/accountkit/LoginResult;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lcom/facebook/accountkit/LoginResult;

    return-object p0
.end method

.method public static values()[Lcom/facebook/accountkit/LoginResult;
    .locals 1

    sget-object v0, Lcom/facebook/accountkit/LoginResult;->$VALUES:[Lcom/facebook/accountkit/LoginResult;

    invoke-virtual {v0}, [Lcom/facebook/accountkit/LoginResult;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/facebook/accountkit/LoginResult;

    return-object v0
.end method
