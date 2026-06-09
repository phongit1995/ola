.class Lcom/mg/ola/common/widget/date/f;
.super Ljava/lang/Object;


# direct methods
.method public static a(Landroid/content/Context;Lcom/mg/ola/common/widget/date/ScrollPickerView$ScrollType;)Lcom/mg/ola/common/widget/date/a;
    .locals 1

    sget-object v0, Lcom/mg/ola/common/widget/date/f$1;->a:[I

    invoke-virtual {p1}, Lcom/mg/ola/common/widget/date/ScrollPickerView$ScrollType;->ordinal()I

    move-result p1

    aget p1, v0, p1

    packed-switch p1, :pswitch_data_0

    const/4 p0, 0x0

    return-object p0

    :pswitch_0
    new-instance p1, Lcom/mg/ola/common/widget/date/b;

    invoke-direct {p1, p0}, Lcom/mg/ola/common/widget/date/b;-><init>(Landroid/content/Context;)V

    return-object p1

    :pswitch_1
    new-instance p1, Lcom/mg/ola/common/widget/date/e;

    invoke-direct {p1, p0}, Lcom/mg/ola/common/widget/date/e;-><init>(Landroid/content/Context;)V

    return-object p1

    :pswitch_2
    new-instance p1, Lcom/mg/ola/common/widget/date/c;

    invoke-direct {p1, p0}, Lcom/mg/ola/common/widget/date/c;-><init>(Landroid/content/Context;)V

    return-object p1

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
