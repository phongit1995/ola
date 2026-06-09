.class public Lchat/ola/vn/g/i;
.super Lchat/ola/vn/g/h;


# instance fields
.field private e:Landroid/widget/TextView;


# direct methods
.method public constructor <init>(Landroid/view/View;)V
    .locals 1

    invoke-direct {p0, p1}, Lchat/ola/vn/g/h;-><init>(Landroid/view/View;)V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/g/i;->e:Landroid/widget/TextView;

    const v0, 0x7f090153

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/g/i;->e:Landroid/widget/TextView;

    return-void
.end method


# virtual methods
.method public b(I)V
    .locals 4

    sget-object p1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {p1}, Lchat/ola/vn/message/g;->E()I

    move-result p1

    if-lez p1, :cond_0

    iget-object v0, p0, Lchat/ola/vn/g/i;->e:Landroid/widget/TextView;

    const v1, 0x7f0f0468

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    aput-object p1, v2, v3

    invoke-static {v1, v2}, Lchat/ola/vn/OlaApplication;->a(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/g/i;->e:Landroid/widget/TextView;

    const v0, 0x7f0f0467

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(I)V

    return-void
.end method
