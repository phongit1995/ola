.class Lchat/ola/vn/util/b/b$1$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/util/b/b$1;->c()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/util/b/b$1;


# direct methods
.method constructor <init>(Lchat/ola/vn/util/b/b$1;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/util/b/b$1$1;->a:Lchat/ola/vn/util/b/b$1;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 0

    iget-object p1, p0, Lchat/ola/vn/util/b/b$1$1;->a:Lchat/ola/vn/util/b/b$1;

    invoke-static {p1}, Lchat/ola/vn/util/b/b$1;->a(Lchat/ola/vn/util/b/b$1;)Lchat/ola/vn/i/l;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/i/l;->dismiss()V

    iget-object p1, p0, Lchat/ola/vn/util/b/b$1$1;->a:Lchat/ola/vn/util/b/b$1;

    iget-object p1, p1, Lchat/ola/vn/util/b/b$1;->b:Lchat/ola/vn/util/b/c;

    invoke-virtual {p1}, Lchat/ola/vn/util/b/c;->a()V

    return-void
.end method
