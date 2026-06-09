.class public final enum Lcom/facebook/accountkit/ui/SkinManager$Tint;
.super Ljava/lang/Enum;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/facebook/accountkit/ui/SkinManager;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4019
    name = "Tint"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/facebook/accountkit/ui/SkinManager$Tint;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/facebook/accountkit/ui/SkinManager$Tint;

.field public static final enum BLACK:Lcom/facebook/accountkit/ui/SkinManager$Tint;

.field public static final enum WHITE:Lcom/facebook/accountkit/ui/SkinManager$Tint;


# direct methods
.method static constructor <clinit>()V
    .locals 4

    new-instance v0, Lcom/facebook/accountkit/ui/SkinManager$Tint;

    const-string v1, "WHITE"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lcom/facebook/accountkit/ui/SkinManager$Tint;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/ui/SkinManager$Tint;->WHITE:Lcom/facebook/accountkit/ui/SkinManager$Tint;

    new-instance v0, Lcom/facebook/accountkit/ui/SkinManager$Tint;

    const-string v1, "BLACK"

    const/4 v3, 0x1

    invoke-direct {v0, v1, v3}, Lcom/facebook/accountkit/ui/SkinManager$Tint;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/ui/SkinManager$Tint;->BLACK:Lcom/facebook/accountkit/ui/SkinManager$Tint;

    const/4 v0, 0x2

    new-array v0, v0, [Lcom/facebook/accountkit/ui/SkinManager$Tint;

    sget-object v1, Lcom/facebook/accountkit/ui/SkinManager$Tint;->WHITE:Lcom/facebook/accountkit/ui/SkinManager$Tint;

    aput-object v1, v0, v2

    sget-object v1, Lcom/facebook/accountkit/ui/SkinManager$Tint;->BLACK:Lcom/facebook/accountkit/ui/SkinManager$Tint;

    aput-object v1, v0, v3

    sput-object v0, Lcom/facebook/accountkit/ui/SkinManager$Tint;->$VALUES:[Lcom/facebook/accountkit/ui/SkinManager$Tint;

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

.method public static valueOf(Ljava/lang/String;)Lcom/facebook/accountkit/ui/SkinManager$Tint;
    .locals 1

    const-class v0, Lcom/facebook/accountkit/ui/SkinManager$Tint;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lcom/facebook/accountkit/ui/SkinManager$Tint;

    return-object p0
.end method

.method public static values()[Lcom/facebook/accountkit/ui/SkinManager$Tint;
    .locals 1

    sget-object v0, Lcom/facebook/accountkit/ui/SkinManager$Tint;->$VALUES:[Lcom/facebook/accountkit/ui/SkinManager$Tint;

    invoke-virtual {v0}, [Lcom/facebook/accountkit/ui/SkinManager$Tint;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/facebook/accountkit/ui/SkinManager$Tint;

    return-object v0
.end method
