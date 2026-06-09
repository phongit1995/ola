.class public Lchat/ola/vn/i/d;
.super Lchat/ola/vn/i/g;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1

    invoke-direct {p0, p1}, Lchat/ola/vn/i/g;-><init>(Landroid/content/Context;)V

    iget-object p1, p0, Lchat/ola/vn/i/d;->c:Landroid/widget/Button;

    const v0, 0x7f08010b

    invoke-virtual {p1, v0}, Landroid/widget/Button;->setBackgroundResource(I)V

    iget-object p1, p0, Lchat/ola/vn/i/d;->c:Landroid/widget/Button;

    const/4 v0, -0x1

    invoke-virtual {p1, v0}, Landroid/widget/Button;->setTextColor(I)V

    return-void
.end method
