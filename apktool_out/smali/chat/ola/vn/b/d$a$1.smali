.class Lchat/ola/vn/b/d$a$1;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/c/g;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/b/d$a;->b()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/b/d$a;


# direct methods
.method constructor <init>(Lchat/ola/vn/b/d$a;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/b/d$a$1;->a:Lchat/ola/vn/b/d$a;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/c/f;)V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/b/d$a$1;->a:Lchat/ola/vn/b/d$a;

    iget-object v0, v0, Lchat/ola/vn/b/d$a;->a:Lcom/google/android/gms/maps/model/Marker;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/b/d$a$1;->a:Lchat/ola/vn/b/d$a;

    iget-object v0, v0, Lchat/ola/vn/b/d$a;->a:Lcom/google/android/gms/maps/model/Marker;

    invoke-virtual {v0}, Lcom/google/android/gms/maps/model/Marker;->getSnippet()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/b/d$a$1;->a:Lchat/ola/vn/b/d$a;

    iget-object v0, v0, Lchat/ola/vn/b/d$a;->a:Lcom/google/android/gms/maps/model/Marker;

    invoke-virtual {v0}, Lcom/google/android/gms/maps/model/Marker;->getSnippet()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1}, Lchat/ola/vn/c/f;->f()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/b/d$a$1;->a:Lchat/ola/vn/b/d$a;

    invoke-static {v0}, Lchat/ola/vn/b/d$a;->b(Lchat/ola/vn/b/d$a;)Landroid/widget/ImageView;

    move-result-object v0

    invoke-virtual {p1}, Lchat/ola/vn/c/f;->c()Landroid/graphics/Bitmap;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/widget/ImageView;->setImageBitmap(Landroid/graphics/Bitmap;)V

    iget-object p1, p0, Lchat/ola/vn/b/d$a$1;->a:Lchat/ola/vn/b/d$a;

    iget-object p1, p1, Lchat/ola/vn/b/d$a;->a:Lcom/google/android/gms/maps/model/Marker;

    invoke-virtual {p1}, Lcom/google/android/gms/maps/model/Marker;->showInfoWindow()V

    :cond_0
    return-void
.end method

.method public b(Lchat/ola/vn/c/f;)V
    .locals 0

    return-void
.end method
