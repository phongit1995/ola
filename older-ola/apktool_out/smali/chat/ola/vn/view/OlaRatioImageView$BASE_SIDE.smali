.class public final enum Lchat/ola/vn/view/OlaRatioImageView$BASE_SIDE;
.super Ljava/lang/Enum;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/view/OlaRatioImageView;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4019
    name = "BASE_SIDE"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lchat/ola/vn/view/OlaRatioImageView$BASE_SIDE;",
        ">;"
    }
.end annotation


# static fields
.field public static final enum a:Lchat/ola/vn/view/OlaRatioImageView$BASE_SIDE;

.field public static final enum b:Lchat/ola/vn/view/OlaRatioImageView$BASE_SIDE;

.field private static final synthetic c:[Lchat/ola/vn/view/OlaRatioImageView$BASE_SIDE;


# direct methods
.method static constructor <clinit>()V
    .locals 4

    new-instance v0, Lchat/ola/vn/view/OlaRatioImageView$BASE_SIDE;

    const-string v1, "BASE_WIDTH"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lchat/ola/vn/view/OlaRatioImageView$BASE_SIDE;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lchat/ola/vn/view/OlaRatioImageView$BASE_SIDE;->a:Lchat/ola/vn/view/OlaRatioImageView$BASE_SIDE;

    new-instance v0, Lchat/ola/vn/view/OlaRatioImageView$BASE_SIDE;

    const-string v1, "BASE_HEIGHT"

    const/4 v3, 0x1

    invoke-direct {v0, v1, v3}, Lchat/ola/vn/view/OlaRatioImageView$BASE_SIDE;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lchat/ola/vn/view/OlaRatioImageView$BASE_SIDE;->b:Lchat/ola/vn/view/OlaRatioImageView$BASE_SIDE;

    const/4 v0, 0x2

    new-array v0, v0, [Lchat/ola/vn/view/OlaRatioImageView$BASE_SIDE;

    sget-object v1, Lchat/ola/vn/view/OlaRatioImageView$BASE_SIDE;->a:Lchat/ola/vn/view/OlaRatioImageView$BASE_SIDE;

    aput-object v1, v0, v2

    sget-object v1, Lchat/ola/vn/view/OlaRatioImageView$BASE_SIDE;->b:Lchat/ola/vn/view/OlaRatioImageView$BASE_SIDE;

    aput-object v1, v0, v3

    sput-object v0, Lchat/ola/vn/view/OlaRatioImageView$BASE_SIDE;->c:[Lchat/ola/vn/view/OlaRatioImageView$BASE_SIDE;

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

.method public static valueOf(Ljava/lang/String;)Lchat/ola/vn/view/OlaRatioImageView$BASE_SIDE;
    .locals 1

    const-class v0, Lchat/ola/vn/view/OlaRatioImageView$BASE_SIDE;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lchat/ola/vn/view/OlaRatioImageView$BASE_SIDE;

    return-object p0
.end method

.method public static values()[Lchat/ola/vn/view/OlaRatioImageView$BASE_SIDE;
    .locals 1

    sget-object v0, Lchat/ola/vn/view/OlaRatioImageView$BASE_SIDE;->c:[Lchat/ola/vn/view/OlaRatioImageView$BASE_SIDE;

    invoke-virtual {v0}, [Lchat/ola/vn/view/OlaRatioImageView$BASE_SIDE;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lchat/ola/vn/view/OlaRatioImageView$BASE_SIDE;

    return-object v0
.end method
