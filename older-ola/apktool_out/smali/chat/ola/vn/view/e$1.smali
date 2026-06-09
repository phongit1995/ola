.class Lchat/ola/vn/view/e$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/view/e;->onSizeChanged(IIII)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/view/e;


# direct methods
.method constructor <init>(Lchat/ola/vn/view/e;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/view/e$1;->a:Lchat/ola/vn/view/e;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/view/e$1;->a:Lchat/ola/vn/view/e;

    invoke-static {v0}, Lchat/ola/vn/view/e;->a(Lchat/ola/vn/view/e;)V

    iget-object v0, p0, Lchat/ola/vn/view/e$1;->a:Lchat/ola/vn/view/e;

    invoke-static {v0}, Lchat/ola/vn/view/e;->b(Lchat/ola/vn/view/e;)Landroid/view/TextureView;

    move-result-object v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/view/e$1;->a:Lchat/ola/vn/view/e;

    invoke-static {v0}, Lchat/ola/vn/view/e;->c(Lchat/ola/vn/view/e;)Landroid/view/ViewStub;

    move-result-object v0

    const v1, 0x7f0b0132

    invoke-virtual {v0, v1}, Landroid/view/ViewStub;->setLayoutResource(I)V

    iget-object v0, p0, Lchat/ola/vn/view/e$1;->a:Lchat/ola/vn/view/e;

    invoke-static {v0}, Lchat/ola/vn/view/e;->c(Lchat/ola/vn/view/e;)Landroid/view/ViewStub;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/ViewStub;->inflate()Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/view/e$1;->a:Lchat/ola/vn/view/e;

    iget-object v1, p0, Lchat/ola/vn/view/e$1;->a:Lchat/ola/vn/view/e;

    const v2, 0x7f090145

    invoke-virtual {v1, v2}, Lchat/ola/vn/view/e;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/view/TextureView;

    invoke-static {v0, v1}, Lchat/ola/vn/view/e;->a(Lchat/ola/vn/view/e;Landroid/view/TextureView;)Landroid/view/TextureView;

    iget-object v0, p0, Lchat/ola/vn/view/e$1;->a:Lchat/ola/vn/view/e;

    invoke-static {v0}, Lchat/ola/vn/view/e;->b(Lchat/ola/vn/view/e;)Landroid/view/TextureView;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/view/e$1;->a:Lchat/ola/vn/view/e;

    invoke-virtual {v0, v1}, Landroid/view/TextureView;->setSurfaceTextureListener(Landroid/view/TextureView$SurfaceTextureListener;)V

    :cond_0
    return-void
.end method
