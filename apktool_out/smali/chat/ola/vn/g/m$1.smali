.class Lchat/ola/vn/g/m$1;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/c/g;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/g/m;->b(I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/g/m;


# direct methods
.method constructor <init>(Lchat/ola/vn/g/m;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/g/m$1;->a:Lchat/ola/vn/g/m;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/c/f;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/g/m$1;->a:Lchat/ola/vn/g/m;

    iget-object v0, v0, Lchat/ola/vn/g/m;->f:Landroid/widget/ImageView;

    invoke-virtual {p1}, Lchat/ola/vn/c/f;->c()Landroid/graphics/Bitmap;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/widget/ImageView;->setImageBitmap(Landroid/graphics/Bitmap;)V

    return-void
.end method

.method public b(Lchat/ola/vn/c/f;)V
    .locals 0

    return-void
.end method
