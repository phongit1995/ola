.class public final enum Lcom/facebook/accountkit/ui/AccountKitActivity$TitleType;
.super Ljava/lang/Enum;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/facebook/accountkit/ui/AccountKitActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4019
    name = "TitleType"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/facebook/accountkit/ui/AccountKitActivity$TitleType;",
        ">;"
    }
.end annotation

.annotation runtime Ljava/lang/Deprecated;
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/facebook/accountkit/ui/AccountKitActivity$TitleType;

.field public static final enum APP_NAME:Lcom/facebook/accountkit/ui/AccountKitActivity$TitleType;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field

.field public static final enum LOGIN:Lcom/facebook/accountkit/ui/AccountKitActivity$TitleType;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 4

    new-instance v0, Lcom/facebook/accountkit/ui/AccountKitActivity$TitleType;

    const-string v1, "APP_NAME"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lcom/facebook/accountkit/ui/AccountKitActivity$TitleType;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/ui/AccountKitActivity$TitleType;->APP_NAME:Lcom/facebook/accountkit/ui/AccountKitActivity$TitleType;

    new-instance v0, Lcom/facebook/accountkit/ui/AccountKitActivity$TitleType;

    const-string v1, "LOGIN"

    const/4 v3, 0x1

    invoke-direct {v0, v1, v3}, Lcom/facebook/accountkit/ui/AccountKitActivity$TitleType;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/ui/AccountKitActivity$TitleType;->LOGIN:Lcom/facebook/accountkit/ui/AccountKitActivity$TitleType;

    const/4 v0, 0x2

    new-array v0, v0, [Lcom/facebook/accountkit/ui/AccountKitActivity$TitleType;

    sget-object v1, Lcom/facebook/accountkit/ui/AccountKitActivity$TitleType;->APP_NAME:Lcom/facebook/accountkit/ui/AccountKitActivity$TitleType;

    aput-object v1, v0, v2

    sget-object v1, Lcom/facebook/accountkit/ui/AccountKitActivity$TitleType;->LOGIN:Lcom/facebook/accountkit/ui/AccountKitActivity$TitleType;

    aput-object v1, v0, v3

    sput-object v0, Lcom/facebook/accountkit/ui/AccountKitActivity$TitleType;->$VALUES:[Lcom/facebook/accountkit/ui/AccountKitActivity$TitleType;

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

.method public static valueOf(Ljava/lang/String;)Lcom/facebook/accountkit/ui/AccountKitActivity$TitleType;
    .locals 1

    const-class v0, Lcom/facebook/accountkit/ui/AccountKitActivity$TitleType;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lcom/facebook/accountkit/ui/AccountKitActivity$TitleType;

    return-object p0
.end method

.method public static values()[Lcom/facebook/accountkit/ui/AccountKitActivity$TitleType;
    .locals 1

    sget-object v0, Lcom/facebook/accountkit/ui/AccountKitActivity$TitleType;->$VALUES:[Lcom/facebook/accountkit/ui/AccountKitActivity$TitleType;

    invoke-virtual {v0}, [Lcom/facebook/accountkit/ui/AccountKitActivity$TitleType;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/facebook/accountkit/ui/AccountKitActivity$TitleType;

    return-object v0
.end method
