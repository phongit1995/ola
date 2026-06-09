.class public Lchat/ola/vn/entry/b/g;
.super Lchat/ola/vn/entry/b/b;


# instance fields
.field private f:Landroid/widget/TextView;


# direct methods
.method public constructor <init>(Landroid/view/View;)V
    .locals 1

    invoke-direct {p0, p1}, Lchat/ola/vn/entry/b/b;-><init>(Landroid/view/View;)V

    const v0, 0x7f09035a

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/entry/b/g;->f:Landroid/widget/TextView;

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/message/d;Lchat/ola/vn/message/d;Lchat/ola/vn/message/d;)V
    .locals 2

    invoke-virtual {p1}, Lchat/ola/vn/message/d;->m()J

    move-result-wide p1

    iget-object p3, p0, Lchat/ola/vn/entry/b/g;->f:Landroid/widget/TextView;

    invoke-static {}, Lchat/ola/vn/b;->d()Lchat/ola/vn/b;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/b;->c()[Ljava/lang/String;

    move-result-object v0

    invoke-static {}, Lchat/ola/vn/b;->d()Lchat/ola/vn/b;

    move-result-object v1

    invoke-virtual {v1}, Lchat/ola/vn/b;->a()[Ljava/lang/String;

    move-result-object v1

    invoke-static {p1, p2, v0, v1}, Lcom/mg/ola/common/d/i;->b(J[Ljava/lang/String;[Ljava/lang/String;)Ljava/lang/CharSequence;

    move-result-object p1

    invoke-virtual {p3, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void
.end method
