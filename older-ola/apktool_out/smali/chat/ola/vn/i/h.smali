.class public Lchat/ola/vn/i/h;
.super Lchat/ola/vn/i/n;

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/i/h$a;
    }
.end annotation


# instance fields
.field private a:Landroid/widget/TextView;

.field private b:Landroid/widget/TextView;

.field private c:Landroid/widget/Button;

.field private d:Landroid/widget/Button;

.field private e:Landroid/widget/CheckBox;

.field private f:Lchat/ola/vn/i/h$a;


# direct methods
.method public constructor <init>(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/i/h$a;)V
    .locals 2

    invoke-direct {p0, p1}, Lchat/ola/vn/i/n;-><init>(Landroid/content/Context;)V

    const v0, 0x7f0b008a

    invoke-virtual {p0, v0}, Lchat/ola/vn/i/h;->setContentView(I)V

    invoke-virtual {p0}, Lchat/ola/vn/i/h;->getWindow()Landroid/view/Window;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/Window;->getAttributes()Landroid/view/WindowManager$LayoutParams;

    move-result-object v0

    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p1

    const v1, 0x7f0700db

    invoke-virtual {p1, v1}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result p1

    iput p1, v0, Landroid/view/WindowManager$LayoutParams;->width:I

    const p1, 0x7f09052a

    invoke-virtual {p0, p1}, Lchat/ola/vn/i/h;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/i/h;->a:Landroid/widget/TextView;

    const p1, 0x7f090513

    invoke-virtual {p0, p1}, Lchat/ola/vn/i/h;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/i/h;->b:Landroid/widget/TextView;

    const p1, 0x7f0900ad

    invoke-virtual {p0, p1}, Lchat/ola/vn/i/h;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/Button;

    iput-object p1, p0, Lchat/ola/vn/i/h;->c:Landroid/widget/Button;

    const p1, 0x7f0900ae

    invoke-virtual {p0, p1}, Lchat/ola/vn/i/h;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/Button;

    iput-object p1, p0, Lchat/ola/vn/i/h;->d:Landroid/widget/Button;

    const p1, 0x7f090166

    invoke-virtual {p0, p1}, Lchat/ola/vn/i/h;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/CheckBox;

    iput-object p1, p0, Lchat/ola/vn/i/h;->e:Landroid/widget/CheckBox;

    iget-object p1, p0, Lchat/ola/vn/i/h;->a:Landroid/widget/TextView;

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/i/h;->b:Landroid/widget/TextView;

    invoke-virtual {p1, p3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/i/h;->c:Landroid/widget/Button;

    const p2, 0x7f0f04a6

    invoke-virtual {p1, p2}, Landroid/widget/Button;->setText(I)V

    iget-object p1, p0, Lchat/ola/vn/i/h;->d:Landroid/widget/Button;

    const p2, 0x7f0f0577

    invoke-virtual {p1, p2}, Landroid/widget/Button;->setText(I)V

    iput-object p4, p0, Lchat/ola/vn/i/h;->f:Lchat/ola/vn/i/h$a;

    iget-object p1, p0, Lchat/ola/vn/i/h;->c:Landroid/widget/Button;

    invoke-virtual {p1, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/i/h;->d:Landroid/widget/Button;

    invoke-virtual {p1, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1

    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    packed-switch p1, :pswitch_data_0

    return-void

    :cond_0
    :goto_0
    :pswitch_0
    invoke-virtual {p0}, Lchat/ola/vn/i/h;->dismiss()V

    return-void

    :pswitch_1
    iget-object p1, p0, Lchat/ola/vn/i/h;->f:Lchat/ola/vn/i/h$a;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/i/h;->f:Lchat/ola/vn/i/h$a;

    iget-object v0, p0, Lchat/ola/vn/i/h;->e:Landroid/widget/CheckBox;

    invoke-virtual {v0}, Landroid/widget/CheckBox;->isChecked()Z

    move-result v0

    invoke-interface {p1, v0}, Lchat/ola/vn/i/h$a;->a(Z)V

    goto :goto_0

    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x7f0900ad
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
