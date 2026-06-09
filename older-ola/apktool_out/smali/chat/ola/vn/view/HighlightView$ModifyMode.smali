.class final enum Lchat/ola/vn/view/HighlightView$ModifyMode;
.super Ljava/lang/Enum;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/view/HighlightView;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4018
    name = "ModifyMode"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lchat/ola/vn/view/HighlightView$ModifyMode;",
        ">;"
    }
.end annotation


# static fields
.field public static final enum a:Lchat/ola/vn/view/HighlightView$ModifyMode;

.field public static final enum b:Lchat/ola/vn/view/HighlightView$ModifyMode;

.field public static final enum c:Lchat/ola/vn/view/HighlightView$ModifyMode;

.field private static final synthetic d:[Lchat/ola/vn/view/HighlightView$ModifyMode;


# direct methods
.method static constructor <clinit>()V
    .locals 5

    new-instance v0, Lchat/ola/vn/view/HighlightView$ModifyMode;

    const-string v1, "None"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lchat/ola/vn/view/HighlightView$ModifyMode;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lchat/ola/vn/view/HighlightView$ModifyMode;->a:Lchat/ola/vn/view/HighlightView$ModifyMode;

    new-instance v0, Lchat/ola/vn/view/HighlightView$ModifyMode;

    const-string v1, "Move"

    const/4 v3, 0x1

    invoke-direct {v0, v1, v3}, Lchat/ola/vn/view/HighlightView$ModifyMode;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lchat/ola/vn/view/HighlightView$ModifyMode;->b:Lchat/ola/vn/view/HighlightView$ModifyMode;

    new-instance v0, Lchat/ola/vn/view/HighlightView$ModifyMode;

    const-string v1, "Grow"

    const/4 v4, 0x2

    invoke-direct {v0, v1, v4}, Lchat/ola/vn/view/HighlightView$ModifyMode;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lchat/ola/vn/view/HighlightView$ModifyMode;->c:Lchat/ola/vn/view/HighlightView$ModifyMode;

    const/4 v0, 0x3

    new-array v0, v0, [Lchat/ola/vn/view/HighlightView$ModifyMode;

    sget-object v1, Lchat/ola/vn/view/HighlightView$ModifyMode;->a:Lchat/ola/vn/view/HighlightView$ModifyMode;

    aput-object v1, v0, v2

    sget-object v1, Lchat/ola/vn/view/HighlightView$ModifyMode;->b:Lchat/ola/vn/view/HighlightView$ModifyMode;

    aput-object v1, v0, v3

    sget-object v1, Lchat/ola/vn/view/HighlightView$ModifyMode;->c:Lchat/ola/vn/view/HighlightView$ModifyMode;

    aput-object v1, v0, v4

    sput-object v0, Lchat/ola/vn/view/HighlightView$ModifyMode;->d:[Lchat/ola/vn/view/HighlightView$ModifyMode;

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

.method public static valueOf(Ljava/lang/String;)Lchat/ola/vn/view/HighlightView$ModifyMode;
    .locals 1

    const-class v0, Lchat/ola/vn/view/HighlightView$ModifyMode;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lchat/ola/vn/view/HighlightView$ModifyMode;

    return-object p0
.end method

.method public static values()[Lchat/ola/vn/view/HighlightView$ModifyMode;
    .locals 1

    sget-object v0, Lchat/ola/vn/view/HighlightView$ModifyMode;->d:[Lchat/ola/vn/view/HighlightView$ModifyMode;

    invoke-virtual {v0}, [Lchat/ola/vn/view/HighlightView$ModifyMode;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lchat/ola/vn/view/HighlightView$ModifyMode;

    return-object v0
.end method
