.class Lchat/ola/vn/view/a$2$2;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/view/a$2;->c(Ljava/lang/String;Landroid/graphics/Bitmap;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Landroid/graphics/Bitmap;

.field final synthetic b:Lchat/ola/vn/view/a$2;


# direct methods
.method constructor <init>(Lchat/ola/vn/view/a$2;Landroid/graphics/Bitmap;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/view/a$2$2;->b:Lchat/ola/vn/view/a$2;

    iput-object p2, p0, Lchat/ola/vn/view/a$2$2;->a:Landroid/graphics/Bitmap;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/view/a$2$2;->b:Lchat/ola/vn/view/a$2;

    iget-object v0, v0, Lchat/ola/vn/view/a$2;->b:Lchat/ola/vn/view/a;

    iget-object v1, p0, Lchat/ola/vn/view/a$2$2;->a:Landroid/graphics/Bitmap;

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/a;->a(Landroid/graphics/Bitmap;)V

    return-void
.end method
