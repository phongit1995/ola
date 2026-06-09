.class public final enum Lcom/facebook/accountkit/ui/AccountKitActivity$ResponseType;
.super Ljava/lang/Enum;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/facebook/accountkit/ui/AccountKitActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4019
    name = "ResponseType"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/facebook/accountkit/ui/AccountKitActivity$ResponseType;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/facebook/accountkit/ui/AccountKitActivity$ResponseType;

.field public static final enum CODE:Lcom/facebook/accountkit/ui/AccountKitActivity$ResponseType;

.field public static final enum TOKEN:Lcom/facebook/accountkit/ui/AccountKitActivity$ResponseType;


# instance fields
.field private final value:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 5

    new-instance v0, Lcom/facebook/accountkit/ui/AccountKitActivity$ResponseType;

    const-string v1, "CODE"

    const-string v2, "code"

    const/4 v3, 0x0

    invoke-direct {v0, v1, v3, v2}, Lcom/facebook/accountkit/ui/AccountKitActivity$ResponseType;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/facebook/accountkit/ui/AccountKitActivity$ResponseType;->CODE:Lcom/facebook/accountkit/ui/AccountKitActivity$ResponseType;

    new-instance v0, Lcom/facebook/accountkit/ui/AccountKitActivity$ResponseType;

    const-string v1, "TOKEN"

    const-string v2, "token"

    const/4 v4, 0x1

    invoke-direct {v0, v1, v4, v2}, Lcom/facebook/accountkit/ui/AccountKitActivity$ResponseType;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/facebook/accountkit/ui/AccountKitActivity$ResponseType;->TOKEN:Lcom/facebook/accountkit/ui/AccountKitActivity$ResponseType;

    const/4 v0, 0x2

    new-array v0, v0, [Lcom/facebook/accountkit/ui/AccountKitActivity$ResponseType;

    sget-object v1, Lcom/facebook/accountkit/ui/AccountKitActivity$ResponseType;->CODE:Lcom/facebook/accountkit/ui/AccountKitActivity$ResponseType;

    aput-object v1, v0, v3

    sget-object v1, Lcom/facebook/accountkit/ui/AccountKitActivity$ResponseType;->TOKEN:Lcom/facebook/accountkit/ui/AccountKitActivity$ResponseType;

    aput-object v1, v0, v4

    sput-object v0, Lcom/facebook/accountkit/ui/AccountKitActivity$ResponseType;->$VALUES:[Lcom/facebook/accountkit/ui/AccountKitActivity$ResponseType;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;ILjava/lang/String;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    iput-object p3, p0, Lcom/facebook/accountkit/ui/AccountKitActivity$ResponseType;->value:Ljava/lang/String;

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/facebook/accountkit/ui/AccountKitActivity$ResponseType;
    .locals 1

    const-class v0, Lcom/facebook/accountkit/ui/AccountKitActivity$ResponseType;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lcom/facebook/accountkit/ui/AccountKitActivity$ResponseType;

    return-object p0
.end method

.method public static values()[Lcom/facebook/accountkit/ui/AccountKitActivity$ResponseType;
    .locals 1

    sget-object v0, Lcom/facebook/accountkit/ui/AccountKitActivity$ResponseType;->$VALUES:[Lcom/facebook/accountkit/ui/AccountKitActivity$ResponseType;

    invoke-virtual {v0}, [Lcom/facebook/accountkit/ui/AccountKitActivity$ResponseType;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/facebook/accountkit/ui/AccountKitActivity$ResponseType;

    return-object v0
.end method


# virtual methods
.method public getValue()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitActivity$ResponseType;->value:Ljava/lang/String;

    return-object v0
.end method
