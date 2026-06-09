.class public final enum Lcom/facebook/accountkit/ui/SkinManager$Skin;
.super Ljava/lang/Enum;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/facebook/accountkit/ui/SkinManager;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4019
    name = "Skin"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/facebook/accountkit/ui/SkinManager$Skin;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/facebook/accountkit/ui/SkinManager$Skin;

.field public static final enum CLASSIC:Lcom/facebook/accountkit/ui/SkinManager$Skin;

.field public static final enum CONTEMPORARY:Lcom/facebook/accountkit/ui/SkinManager$Skin;

.field public static final enum NONE:Lcom/facebook/accountkit/ui/SkinManager$Skin;

.field public static final enum TRANSLUCENT:Lcom/facebook/accountkit/ui/SkinManager$Skin;


# direct methods
.method static constructor <clinit>()V
    .locals 6

    new-instance v0, Lcom/facebook/accountkit/ui/SkinManager$Skin;

    const-string v1, "NONE"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lcom/facebook/accountkit/ui/SkinManager$Skin;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/ui/SkinManager$Skin;->NONE:Lcom/facebook/accountkit/ui/SkinManager$Skin;

    new-instance v0, Lcom/facebook/accountkit/ui/SkinManager$Skin;

    const-string v1, "CLASSIC"

    const/4 v3, 0x1

    invoke-direct {v0, v1, v3}, Lcom/facebook/accountkit/ui/SkinManager$Skin;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/ui/SkinManager$Skin;->CLASSIC:Lcom/facebook/accountkit/ui/SkinManager$Skin;

    new-instance v0, Lcom/facebook/accountkit/ui/SkinManager$Skin;

    const-string v1, "CONTEMPORARY"

    const/4 v4, 0x2

    invoke-direct {v0, v1, v4}, Lcom/facebook/accountkit/ui/SkinManager$Skin;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/ui/SkinManager$Skin;->CONTEMPORARY:Lcom/facebook/accountkit/ui/SkinManager$Skin;

    new-instance v0, Lcom/facebook/accountkit/ui/SkinManager$Skin;

    const-string v1, "TRANSLUCENT"

    const/4 v5, 0x3

    invoke-direct {v0, v1, v5}, Lcom/facebook/accountkit/ui/SkinManager$Skin;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/ui/SkinManager$Skin;->TRANSLUCENT:Lcom/facebook/accountkit/ui/SkinManager$Skin;

    const/4 v0, 0x4

    new-array v0, v0, [Lcom/facebook/accountkit/ui/SkinManager$Skin;

    sget-object v1, Lcom/facebook/accountkit/ui/SkinManager$Skin;->NONE:Lcom/facebook/accountkit/ui/SkinManager$Skin;

    aput-object v1, v0, v2

    sget-object v1, Lcom/facebook/accountkit/ui/SkinManager$Skin;->CLASSIC:Lcom/facebook/accountkit/ui/SkinManager$Skin;

    aput-object v1, v0, v3

    sget-object v1, Lcom/facebook/accountkit/ui/SkinManager$Skin;->CONTEMPORARY:Lcom/facebook/accountkit/ui/SkinManager$Skin;

    aput-object v1, v0, v4

    sget-object v1, Lcom/facebook/accountkit/ui/SkinManager$Skin;->TRANSLUCENT:Lcom/facebook/accountkit/ui/SkinManager$Skin;

    aput-object v1, v0, v5

    sput-object v0, Lcom/facebook/accountkit/ui/SkinManager$Skin;->$VALUES:[Lcom/facebook/accountkit/ui/SkinManager$Skin;

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

.method public static valueOf(Ljava/lang/String;)Lcom/facebook/accountkit/ui/SkinManager$Skin;
    .locals 1

    const-class v0, Lcom/facebook/accountkit/ui/SkinManager$Skin;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lcom/facebook/accountkit/ui/SkinManager$Skin;

    return-object p0
.end method

.method public static values()[Lcom/facebook/accountkit/ui/SkinManager$Skin;
    .locals 1

    sget-object v0, Lcom/facebook/accountkit/ui/SkinManager$Skin;->$VALUES:[Lcom/facebook/accountkit/ui/SkinManager$Skin;

    invoke-virtual {v0}, [Lcom/facebook/accountkit/ui/SkinManager$Skin;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/facebook/accountkit/ui/SkinManager$Skin;

    return-object v0
.end method
