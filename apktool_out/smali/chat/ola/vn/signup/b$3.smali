.class Lchat/ola/vn/signup/b$3;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/signup/b;->onClick(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/signup/b;


# direct methods
.method constructor <init>(Lchat/ola/vn/signup/b;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/signup/b$3;->a:Lchat/ola/vn/signup/b;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 1

    const/4 v0, 0x1

    if-eq p2, v0, :cond_0

    goto :goto_0

    :cond_0
    :try_start_0
    iget-object p2, p0, Lchat/ola/vn/signup/b$3;->a:Lchat/ola/vn/signup/b;

    invoke-virtual {p2}, Lchat/ola/vn/signup/b;->v()V

    :goto_0
    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
