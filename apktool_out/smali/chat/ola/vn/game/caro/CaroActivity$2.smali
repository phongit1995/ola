.class Lchat/ola/vn/game/caro/CaroActivity$2;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/game/caro/CaroActivity;->c(II)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:I

.field final synthetic b:I

.field final synthetic c:Lchat/ola/vn/game/caro/CaroActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/game/caro/CaroActivity;II)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/game/caro/CaroActivity$2;->c:Lchat/ola/vn/game/caro/CaroActivity;

    iput p2, p0, Lchat/ola/vn/game/caro/CaroActivity$2;->a:I

    iput p3, p0, Lchat/ola/vn/game/caro/CaroActivity$2;->b:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/game/caro/CaroActivity$2;->c:Lchat/ola/vn/game/caro/CaroActivity;

    invoke-static {v0}, Lchat/ola/vn/game/caro/CaroActivity;->b(Lchat/ola/vn/game/caro/CaroActivity;)Landroid/widget/HorizontalScrollView;

    move-result-object v0

    iget v1, p0, Lchat/ola/vn/game/caro/CaroActivity$2;->a:I

    iget v2, p0, Lchat/ola/vn/game/caro/CaroActivity$2;->b:I

    invoke-virtual {v0, v1, v2}, Landroid/widget/HorizontalScrollView;->scrollTo(II)V

    return-void
.end method
