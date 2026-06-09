.class public Lchat/ola/vn/pickercontacts/d;
.super Lchat/ola/vn/pickercontacts/e;


# instance fields
.field private d:Landroid/widget/TextView;


# direct methods
.method public constructor <init>(Landroid/view/View;)V
    .locals 1

    invoke-direct {p0, p1}, Lchat/ola/vn/pickercontacts/e;-><init>(Landroid/view/View;)V

    const v0, 0x7f090523

    :try_start_0
    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/pickercontacts/d;->d:Landroid/widget/TextView;

    invoke-virtual {p1, p0}, Landroid/view/View;->setTag(Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/pickercontacts/c;)V
    .locals 1

    iput-object p1, p0, Lchat/ola/vn/pickercontacts/d;->a:Lchat/ola/vn/pickercontacts/c;

    iget-object v0, p0, Lchat/ola/vn/pickercontacts/d;->d:Landroid/widget/TextView;

    invoke-virtual {p1}, Lchat/ola/vn/pickercontacts/c;->a()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void
.end method
