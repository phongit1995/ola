.class final enum Lcom/facebook/accountkit/internal/Initializer$State;
.super Ljava/lang/Enum;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/facebook/accountkit/internal/Initializer;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x401a
    name = "State"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/facebook/accountkit/internal/Initializer$State;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/facebook/accountkit/internal/Initializer$State;

.field public static final enum FAILED:Lcom/facebook/accountkit/internal/Initializer$State;

.field public static final enum INITIALIZED:Lcom/facebook/accountkit/internal/Initializer$State;

.field public static final enum UNINITIALIZED:Lcom/facebook/accountkit/internal/Initializer$State;


# direct methods
.method static constructor <clinit>()V
    .locals 5

    new-instance v0, Lcom/facebook/accountkit/internal/Initializer$State;

    const-string v1, "UNINITIALIZED"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lcom/facebook/accountkit/internal/Initializer$State;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/internal/Initializer$State;->UNINITIALIZED:Lcom/facebook/accountkit/internal/Initializer$State;

    new-instance v0, Lcom/facebook/accountkit/internal/Initializer$State;

    const-string v1, "INITIALIZED"

    const/4 v3, 0x1

    invoke-direct {v0, v1, v3}, Lcom/facebook/accountkit/internal/Initializer$State;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/internal/Initializer$State;->INITIALIZED:Lcom/facebook/accountkit/internal/Initializer$State;

    new-instance v0, Lcom/facebook/accountkit/internal/Initializer$State;

    const-string v1, "FAILED"

    const/4 v4, 0x2

    invoke-direct {v0, v1, v4}, Lcom/facebook/accountkit/internal/Initializer$State;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/internal/Initializer$State;->FAILED:Lcom/facebook/accountkit/internal/Initializer$State;

    const/4 v0, 0x3

    new-array v0, v0, [Lcom/facebook/accountkit/internal/Initializer$State;

    sget-object v1, Lcom/facebook/accountkit/internal/Initializer$State;->UNINITIALIZED:Lcom/facebook/accountkit/internal/Initializer$State;

    aput-object v1, v0, v2

    sget-object v1, Lcom/facebook/accountkit/internal/Initializer$State;->INITIALIZED:Lcom/facebook/accountkit/internal/Initializer$State;

    aput-object v1, v0, v3

    sget-object v1, Lcom/facebook/accountkit/internal/Initializer$State;->FAILED:Lcom/facebook/accountkit/internal/Initializer$State;

    aput-object v1, v0, v4

    sput-object v0, Lcom/facebook/accountkit/internal/Initializer$State;->$VALUES:[Lcom/facebook/accountkit/internal/Initializer$State;

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

.method public static valueOf(Ljava/lang/String;)Lcom/facebook/accountkit/internal/Initializer$State;
    .locals 1

    const-class v0, Lcom/facebook/accountkit/internal/Initializer$State;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lcom/facebook/accountkit/internal/Initializer$State;

    return-object p0
.end method

.method public static values()[Lcom/facebook/accountkit/internal/Initializer$State;
    .locals 1

    sget-object v0, Lcom/facebook/accountkit/internal/Initializer$State;->$VALUES:[Lcom/facebook/accountkit/internal/Initializer$State;

    invoke-virtual {v0}, [Lcom/facebook/accountkit/internal/Initializer$State;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/facebook/accountkit/internal/Initializer$State;

    return-object v0
.end method
